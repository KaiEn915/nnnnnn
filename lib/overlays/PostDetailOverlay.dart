import 'package:flutter/material.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/noUpload/NotificationService.dart';

class PostDetailOverlay extends StatefulWidget {
  final String postId;
  const PostDetailOverlay({super.key, required this.postId});

  @override
  State<PostDetailOverlay> createState() => _PostComment();
}

class _PostComment extends State<PostDetailOverlay> {
  late final dbRef;
  late TextEditingController _commentController;

  Future<void> saveComment({
    required String content,
  }) async {

    final postComment = {
      "content": content,
      "timestamp": DateTime.now(),
      "owner_uid": AuthService.uid,
    };
    await dbRef.collection('comments').add(postComment);

    final postDoc = await dbRef.collection('posts').doc(widget.postId).get();
    final ownerUid = postDoc.data()?['owner_uid'];
    if (ownerUid == AuthService.uid) return;

    // 4. 获取owner用户文档，取fcmToken
    final ownerDoc = await AuthService.db.collection('users').doc(ownerUid).get();
    final ownerToken = ownerDoc.data()?['fcmToken'] as String?;

    if (ownerToken != null && ownerToken.isNotEmpty) {
      // 5. 发送推送通知
      await NotificationService.sendPushNotification(
        ownerToken,
        "New Comment on Your Post",
        content,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    dbRef = AuthService.db.collection("posts").doc(widget.postId);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 349,
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xFFFBD5FF), Color(0xFFFFC9CA)],
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 3, color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 5,
              children: [
                // Text for instructions
                Container(
                  height: 96,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Write your comment at the section below',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF780006),
                        fontSize: 20,
                        fontFamily: 'Iceland',
                        height: 1.2,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Color(0x40000000),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 349,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFE6F7FF),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    width: 265,
                    child: TextField(
                      controller: _commentController,
                      maxLines: 5,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: "Your Comment",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 349,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Container(
                          width: 103,
                          height: 51,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(top: 12),
                            width: 99,
                            height: 35,
                            decoration: ShapeDecoration(
                              color: Color(0xFFDF9797),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(width: 0.5),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Give Up',
                                style: TextStyle(
                                  color: Color(0xFF560101),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async{
                          String comment = _commentController.text;
                          if (comment.isNotEmpty) {
                            await saveComment(content: comment);
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please write a comment!')),
                            );
                          }
                        },
                        child: Container(
                          width: 103,
                          height: 51,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(top: 12),
                            width: 99,
                            height: 35,
                            decoration: ShapeDecoration(
                              color: Color(0xFF97DFA9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(width: 0.5),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Send',
                                style: TextStyle(
                                  color: Color(0xFF015620),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: -35,
              left: 130,
              child: Image.asset(
                "assets/images/cat2.png",
                width: 50,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
