import 'dart:convert';
import 'package:gan/pages/UserProfile.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/overlays/PostDetailOverlay.dart';
import 'package:gan/pages/GroupChatRoom.dart';
import 'package:gan/pages/Home.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/GroupChatService.dart';
import 'package:gan/services/ImageService.dart';
import 'package:gan/services/MapService.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:gan/services/PostService.dart';
import 'package:gan/utils/OurUI.dart';
import 'package:gan/widgets/AppButton.dart';
import 'package:gan/widgets/OurFont.dart';
import 'package:gan/widgets/PostAttribute.dart';
import 'package:gan/widgets/TopBar.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key, required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: AuthService.db.collection('posts').doc(widget.id).get(),
        builder: (context, snapshot) {
          final data = snapshot.data?.data();
          if (data == null) {
            return Center(child: CircularProgressIndicator());
          }

          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background2.png'),
                fit: BoxFit.cover,
              ),
            ),

            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 825,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xBFC2E1F0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Container(
                            width: 200,
                            height: 200,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xBFF9FFEF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: ImageService.tryDisplayImage(
                              data['imageData'],
                            ),
                          ),
                        ),
                        Container(
                          width: 350,
                          height: 200,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 13,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: OurUI.shapeDecoration(),
                          child: SingleChildScrollView(
                            child: Scrollbar(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 5,
                                children: [
                                  FutureBuilder<Widget>(
                                    future: PostAttribute.address(
                                      context,
                                      data['locationCoordinates'],
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return PostAttribute(
                                          title: "Loading address...",
                                          icon: Icon(
                                            Icons.pin_drop,
                                            color: Colors.grey,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return PostAttribute(
                                          title: "Location unavailable",
                                          icon: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        );
                                      } else {
                                        return snapshot.data!;
                                      }
                                    },
                                  ),
                                  PostAttribute.postOwner(
                                    context,
                                    data['username'],
                                    data['owner_uid'],
                                  ),
                                  PostAttribute.since(data['timestamp']),
                                  PostAttribute.phoneNumber(
                                    data['phoneNumber'],
                                  ),
                                  PostAttribute.email(data['email']),
                                  PostAttribute.description(
                                    data['description'],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 350,
                          height: 200,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          clipBehavior: Clip.antiAlias,
                          decoration: OurUI.shapeDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 5,
                            children: [
                              SizedBox(
                                width: 302,
                                height: 32,
                                child: OurFont(text: "COMMENTS"),
                              ),
                              Container(
                                height: 150,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: AuthService.db
                                      .collection("posts")
                                      .doc(data['id'])
                                      .collection("comments")
                                      .orderBy("timestamp", descending: true)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    final comments = snapshot.data!.docs;
                                    if (comments.isEmpty) {
                                      return Center(child: Text("No comments"));
                                    }

                                    final uniqueUids = comments
                                        .map(
                                          (doc) => doc['owner_uid'] as String,
                                        )
                                        .toSet()
                                        .toList();

                                    return FutureBuilder<
                                      List<
                                        DocumentSnapshot<Map<String, dynamic>>
                                      >
                                    >(
                                      future: Future.wait(
                                        uniqueUids.map(
                                          (uid) => AuthService.db
                                              .collection('users')
                                              .doc(uid)
                                              .get(),
                                        ),
                                      ),
                                      builder: (context, userSnapshots) {
                                        if (!userSnapshots.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        final userMap = {
                                          for (var snap in userSnapshots.data!)
                                            if (snap.exists)
                                              snap.id: snap.data()!,
                                        };

                                        return ListView.builder(
                                          itemCount: comments.length,
                                          itemBuilder: (context, index) {
                                            final commentData = comments[index];
                                            final userId =
                                                commentData['owner_uid'];
                                            final user = userMap[userId];
                                            final timestamp =
                                                commentData['timestamp'];

                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 4,
                                              ),
                                              width: 300,
                                              height: 60,
                                              decoration: ShapeDecoration(
                                                color: Colors.white.withAlpha(
                                                  128,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  // User avatar
                                                  Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    child:GestureDetector(
                                                      onTap: (){NavigatorService.openPage(UserProfile(viewingUID: commentData['owner_uid']), context, false);},
                                                      child: Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration: ShapeDecoration(
                                                          image:
                                                          user != null &&
                                                              user['imageData'] !=
                                                                  null
                                                              ? DecorationImage(
                                                            image: MemoryImage(
                                                              base64Decode(
                                                                user['imageData'],
                                                              ),
                                                            ),
                                                            fit: BoxFit
                                                                .cover,
                                                          )
                                                              : null,
                                                          shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              width: 0.10,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ),

                                                  // Username
                                                  Positioned(
                                                    left: 45,
                                                    top: 0,
                                                    right: 0,
                                                    child: Text(
                                                      user?['username'] ??
                                                          "Unknown",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontFamily: 'Iceland',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        decoration:
                                                            TextDecoration.none,
                                                      ),
                                                    ),
                                                  ),

                                                  // Comment content
                                                  Positioned(
                                                    left: 45,
                                                    right: 0,
                                                    top: 15,
                                                    bottom: 0,
                                                    child:
                                                        // Comment content (scrollable)
                                                        Positioned(
                                                          left: 45,
                                                          right: 0,
                                                          top: 15,
                                                          bottom: 15,
                                                          child: SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            child: Text(
                                                              commentData['content'],
                                                              style: TextStyle(
                                                                color: Color(
                                                                  0xFF828282,
                                                                ),
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                  ),

                                                  // Time ago
                                                  Positioned(
                                                    right: 4,
                                                    bottom: 4,
                                                    child: Text(
                                                      timestamp is Timestamp
                                                          ? timeago.format(
                                                              timestamp
                                                                  .toDate(),
                                                              locale: 'en',
                                                            )
                                                          : '',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontFamily: 'Iceland',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        decoration:
                                                            TextDecoration.none,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 350,
                          height: 37,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          clipBehavior: Clip.antiAlias,
                          decoration: OurUI.shapeDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 15,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final userSnapshot = await AuthService
                                      .userDocRef
                                      .get();
                                  final userData = userSnapshot.data();
                                  final userGroupChats =
                                      userData?['activeGroupChats_id'];
                                  final currentPostGroupChatId =
                                      data['groupChat_id'];

                                  if (currentPostGroupChatId == null ||
                                      currentPostGroupChatId.isEmpty) {
                                    Fluttertoast.showToast(
                                      msg:
                                          "Group chat doesn't exist for this post",
                                    );
                                    if (AuthService.uid == data['owner_uid']) {
                                      await GroupChatService.promptForCreateGroupChat(
                                        context,
                                        data['id'],
                                      );
                                      setState(() {});
                                    }

                                    return;
                                  }

                                  if (userGroupChats is List &&
                                      userGroupChats.contains(
                                        currentPostGroupChatId,
                                      )) {
                                    NavigatorService.openPage(
                                      GroupChatRoom(id: data['groupChat_id']),
                                      context,
                                      true,
                                    );
                                    return;
                                  }

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Join Group"),
                                        content: Text(
                                          "Do you agree to join this group?",
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              final groupChatId =
                                                  data['groupChat_id'];
                                              GroupChatService.joinGroupChat(
                                                groupChatId,
                                              );

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      GroupChatRoom(
                                                        id: groupChatId,
                                                      ),
                                                ),
                                              );
                                            },
                                            child: Text("Join"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Icon(Icons.group, size: 30),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return PostDetailOverlay(
                                        postId: data['id'],
                                      );
                                    },
                                  );
                                },
                                child: Icon(Icons.add_comment, size: 30),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final snapshot = await AuthService.userDocRef
                                      .get();
                                  final favorites =
                                      snapshot.data()?['favoritePosts_id'] ??
                                      [];

                                  bool isPostFavorited = favorites.contains(
                                    data['id'],
                                  );
                                  if (isPostFavorited) {
                                    await PostService.unfavoritePost(
                                      data['id'],
                                    );
                                  } else {
                                    await PostService.favoritePost(data['id']);
                                  }
                                },
                                child: Icon(Icons.bookmark, size: 30),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TopBar(
                  isMiddleSearchBar: false,
                  header: data['title'],
                  leftIcon: Icons.arrow_back,
                  leftIcon_onTap: () {
                    Navigator.pop(context);
                  },
                  rightIcon: data['owner_uid'] == AuthService.uid
                      ? Icons.delete
                      : null,
                  rightIcon_onTap: () async {
                    await PostService.deletePost(data['id']);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
