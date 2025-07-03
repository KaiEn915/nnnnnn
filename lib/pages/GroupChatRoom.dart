import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gan/pages/GroupChatDetail.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/ImageService.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:gan/widgets/TopBar.dart';

import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class GroupChatRoom extends StatefulWidget {
  const GroupChatRoom({super.key, required this.id});

  final String id;

  @override
  State<GroupChatRoom> createState() => _GroupChatRoomWidgetState();
}

class _GroupChatRoomWidgetState extends State<GroupChatRoom> {
  late final dbRef;
  late TextEditingController _chatController;

  Future<void> saveChat({
    required String content,
    bool isImageMessage = false,
  }) async {
    final uid = AuthService.uid;

    // 获取当前用户资料
    final userData = await AuthService.getUserData(uid);
    final username = userData?['username'];

    final postChat = {
      "content": content,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "uid": AuthService.uid,
      "username": username,
      "isImageMessage": isImageMessage,
    };

    await dbRef.collection('messages').add(postChat);
  }

  void onTapImage(String imageData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white, // solid white background
          child: Container(
            height: 400,
            color: Colors.white.withAlpha(64),
            child: Stack(
              children: [
                PhotoView(
                  imageProvider: MemoryImage(base64Decode(imageData)),
                  backgroundDecoration: BoxDecoration(
                    color: Colors.white.withAlpha(64),
                  ),
                  maxScale: 0.5,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.download, color: Colors.black),
                    onPressed: () async {
                      ImageService.saveImage(imageData);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    dbRef = AuthService.db.collection("groupChats").doc(widget.id);
    _chatController = TextEditingController();
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  /// 发送消息并清空输入框
  void _sendMessage() {
    String message = _chatController.text.trim();
    if (message.isNotEmpty) {
      saveChat(content: message);
      print("发送消息: $message");
      _chatController.clear();
    }
  }

  Future<void> sendImage() async {
    XFile? image = await ImageService.pickImage(ImageSource.gallery);
    if (image == null) return;
    final bytes = await File(image.path).readAsBytes();
    String content = base64Encode(bytes);
    saveChat(content: content, isImageMessage: true);
  }

  @override
  Widget build(BuildContext context) {
    return dbRef == null
        ? CircularProgressIndicator()
        : Material(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background2.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 80,
                        left: 0,
                        right: 0,
                        bottom: 80,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: dbRef
                              .collection('messages') // 👈 子集合
                              .orderBy('timestamp', descending: false)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            final messages = snapshot.data!.docs;

                            return ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final isImageMessage =
                                    messages[index]['isImageMessage'];
                                final message = messages[index]['content'];
                                final timestamp = messages[index]['timestamp'];
                                final messageUid = messages[index]['uid'];
                                final senderName = messages[index]['username'];
                                final currentUid = AuthService.uid;
                                final time =
                                    DateTime.fromMillisecondsSinceEpoch(
                                      timestamp,
                                    );
                                final formattedTime =
                                    "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

                                return GestureDetector(
                                  onLongPressStart: (details) {
                                    showMenu(
                                      context: context,
                                      position: RelativeRect.fromLTRB(
                                        details.globalPosition.dx,
                                        details.globalPosition.dy,
                                        details.globalPosition.dx,
                                        details.globalPosition.dy,
                                      ),
                                      items: [
                                        const PopupMenuItem<String>(
                                          value: 'delete',
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                  onTap: () {
                                    if (isImageMessage) onTapImage(message);
                                  },
                                  child: Align(
                                    alignment: messageUid == currentUid
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: messageUid == currentUid
                                            ? Colors.white.withAlpha(204)
                                            : Colors.blue[100],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            messageUid == currentUid
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            messageUid == currentUid
                                                ? "You"
                                                : senderName, // or "other"
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: messageUid == currentUid
                                                  ? Colors.blueAccent
                                                  : Colors.green,
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                child: isImageMessage
                                                    ? Image.memory(
                                                        base64Decode(message),
                                                        height: 100,
                                                      )
                                                    : Text(
                                                        message,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                formattedTime,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 67,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/blue.png"),
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width,
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 5,
                              bottom: 5,
                            ),
                            height: 60,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              //里面的蓝色
                              color: const Color(0xBFE9FBFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 0,
                              children: [
                                Container(
                                  width: 300,
                                  child: TextField(
                                    controller: _chatController,
                                    decoration: InputDecoration(
                                      hintText: "Your Text",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: sendImage,
                                  child: Container(
                                    width: 35,
                                    height: 39,
                                    child: Icon(Icons.file_upload_outlined),
                                  ),
                                ),

                                IconButton(
                                  icon: Icon(Icons.send, size: 30),
                                  onPressed: _sendMessage,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TopBar(
                        isMiddleSearchBar: false,
                        header: "GROUP CHAT",
                        leftIcon: Icons.arrow_back,
                        leftIcon_onTap: () => {
                          Navigator.pushNamed(context, "/GroupChat"),
                        },
                        rightIcon: Icons.error_outline,
                        rightIcon_onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GroupChatDetail(groupChatId: widget.id),
                            ),
                          ),
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
