import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gan/pages/GroupChatDetail.dart';
import 'package:gan/pages/TakePicture.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/GroupChatService.dart';
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
      GroupChatService.saveMessageTo(groupChatRef: dbRef, content: message);
      print("发送消息: $message");
      _chatController.clear();
    }
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
                              .collection('messages')
                              .orderBy('timestamp', descending: false)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }

                            final messages = snapshot.data!.docs;

                            return ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final doc = messages[index];
                                final messageId = doc.id;
                                final data = doc.data() as Map<String, dynamic>;

                                final isImageMessage =
                                    data['isImageMessage'] ?? false;
                                final message = data['content'] ?? '';
                                final senderUid = data['owner_uid'];
                                final timestamp = data['timestamp'];
                                final time =
                                    DateTime.fromMillisecondsSinceEpoch(
                                      timestamp,
                                    );
                                final formattedTime =
                                    "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                                final currentUid = AuthService.uid;

                                return FutureBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>
                                >(
                                  future: AuthService.db
                                      .collection('users')
                                      .doc(senderUid)
                                      .get(),
                                  builder: (context, senderSnapshot) {
                                    if (!senderSnapshot.hasData) {
                                      return SizedBox(); // return empty space to avoid layout shift
                                    }

                                    final senderData = senderSnapshot.data!
                                        .data();
                                    if (senderData == null) return SizedBox();

                                    final username = senderUid == currentUid
                                        ? "You"
                                        : senderData['username'] ?? 'User';
                                    final imageData = senderData['imageData'];

                                    return GestureDetector(
                                      onLongPressStart: (details) async {
                                        final selected = await showMenu<String>(
                                          context: context,
                                          position: RelativeRect.fromLTRB(
                                            details.globalPosition.dx,
                                            details.globalPosition.dy,
                                            details.globalPosition.dx,
                                            details.globalPosition.dy,
                                          ),
                                          items: const [
                                            PopupMenuItem<String>(
                                              value: 'delete',
                                              child: Text('Delete'),
                                            ),
                                          ],
                                        );

                                        if (selected == 'delete') {
                                          GroupChatService.deleteMessageFrom(
                                            dbRef,
                                            messageId,
                                          );
                                        }
                                      },
                                      onTap: () {
                                        if (isImageMessage) onTapImage(message);
                                      },
                                      child: Align(
                                        alignment: senderUid == currentUid
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 6,
                                            horizontal: 6,
                                          ),
                                          constraints: BoxConstraints(
                                            maxWidth:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.75,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                senderUid == currentUid
                                                ? MainAxisAlignment.end
                                                : MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            spacing: 8,
                                            children: [
                                              if (senderUid != currentUid)
                                                ClipOval(
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child:
                                                        ImageService.tryDisplayImage(
                                                          imageData??null,
                                                          40,
                                                        ),
                                                  ),
                                                ),

                                              // Chat bubble
                                              Flexible(
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                    10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        senderUid == currentUid
                                                        ? Colors.white
                                                              .withAlpha(220)
                                                        : Colors.blue[100],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        senderUid == currentUid
                                                        ? CrossAxisAlignment.end
                                                        : CrossAxisAlignment
                                                              .start,
                                                    children: [
                                                      Text(
                                                        username,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          color:
                                                              senderUid ==
                                                                  currentUid
                                                              ? Colors
                                                                    .blueAccent
                                                              : Colors.green,
                                                        ),
                                                      ),
                                                      isImageMessage
                                                          ? ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    8,
                                                                  ),
                                                              child:
                                                                  Image.memory(
                                                                    base64Decode(
                                                                      message,
                                                                    ),
                                                                    height: 120,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                            )
                                                          : Text(
                                                              message,
                                                              style:
                                                                  const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .black87,
                                                                  ),
                                                            ),
                                                      Text(
                                                        formattedTime,
                                                        style: const TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // Avatar (for self only)
                                              if (senderUid == currentUid)
                                                ClipOval(
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child:ImageService.tryDisplayImage(imageData??"", 40)
                                                  )
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
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
                                  width: 265,
                                  child: TextField(
                                    controller: _chatController,
                                    decoration: InputDecoration(
                                      hintText: "Your Text",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final image =
                                        await ImageService.promptPicture(
                                          context,
                                          true,
                                        );
                                    final bytes = await image.readAsBytes();
                                    final imageData = base64Encode(bytes);
                                    GroupChatService.saveMessageTo(
                                      groupChatRef: dbRef,
                                      content: imageData,
                                      isImageMessage: true,
                                    );
                                  },
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    child: Icon(Icons.camera_alt),
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
