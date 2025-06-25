import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/pages/GroupChatRoom.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/ImageService.dart';
import 'package:gan/services/MapService.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:gan/utils/OurUI.dart';
import 'package:gan/widgets/AppButton.dart';
import 'package:gan/widgets/OurFont.dart';
import 'package:gan/widgets/PostAttribute.dart';
import 'package:gan/widgets/TopBar.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key, required this.postData});

  final Map<String, dynamic> postData;

  @override
  State<StatefulWidget> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  bool get isOwner => widget.postData['ownerUid'] == AuthService.uid;
  String address = "";

  @override
  @override
  void initState() {
    super.initState();
    loadAddress();
  }

  Future<void> loadAddress() async {
    final address = await MapService.getAddressFromCoordinates(
      widget.postData['locationCoordinates'],
    );

    setState(() {
      this.address = address;
    });
  }

  Future<void> deletePost(BuildContext context) async {
    await AuthService.db
        .collection("posts")
        .doc(widget.postData['id'])
        .delete();

    Navigator.pop(context, "postDeleted");
    Fluttertoast.showToast(msg: "Post deleted successfully");
  }



  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                        widget.postData['imageData'],
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
                                widget.postData['locationCoordinates'],
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
                                    icon: Icon(Icons.error, color: Colors.red),
                                  );
                                } else {
                                  return snapshot.data!;
                                }
                              },
                            ),
                            PostAttribute.postOwner(
                              context,
                              widget.postData['username'],
                              widget.postData['ownerUid'],
                            ),
                            PostAttribute.since(widget.postData['timestamp']),
                            PostAttribute.phoneNumber(
                              widget.postData['phoneNumber'],
                            ),
                            PostAttribute.email(widget.postData['email']),
                            PostAttribute.description(
                              widget.postData['description'],
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
                          height: 100,
                          child: SingleChildScrollView(
                            child: Scrollbar(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 10,
                                children: [
                                  Container(
                                    width: 300,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 128,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: ShapeDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "https://placehold.co/32x32",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(width: 0.10),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 40,
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            height: 15,
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Chok Yun Ying',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Iceland',
                                                fontWeight: FontWeight.w400,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 45,
                                          right: 0,
                                          top: 15,
                                          bottom: 0,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            height: 30,
                                            child: Scrollbar(
                                              child: SingleChildScrollView(
                                                child: Text(
                                                  'Don’t give up living!' * 34,
                                                  style: TextStyle(
                                                    color: Color(0xFF828282),
                                                    fontSize: 12,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    decoration:
                                                        TextDecoration.none,
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
                            ),
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
                          onTap:(){
                            AuthService.updateUserData();
                            final groupChats = AuthService.userData?['groupChats'];
                            final groupChatId = widget.postData['groupChatId'];
                            if (groupChats is List && groupChats.contains(groupChatId)) {
                              NavigatorService.openPage(GroupChatRoom(id: widget.postData['groupChatId']), context, true);
                              return;
                            }


                            if (groupChatId == null || groupChatId.isEmpty) {
                              Fluttertoast.showToast(msg: "Group chat doesn't exist for this post");
                              if (isOwner){
                                AuthService.promptForCreateGroupChat(context,widget.postData['id']);
                              }
                              return;
                            }
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Join Group"),
                                  content: Text("Do you agree to join this group?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async{
                                        Navigator.pop(context);
                                        final groupChatId=widget.postData['groupChatId'];
                                        await AuthService.joinGroupChat(context,groupChatId);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => GroupChatRoom(id:groupChatId)),
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
                          onTap:(){


                          },
                          child: Icon(Icons.add_comment, size: 30),
                        ),
                        GestureDetector(
                          onTap:(){},
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
            header: widget.postData['title'],
            leftIcon: Icons.arrow_back,
            leftIcon_onTap: () {
              Navigator.pop(context);
            },
            rightIcon: isOwner ? Icons.delete : null,
            rightIcon_onTap: () async {
              await deletePost(context);
            },
          ),
        ],
      ),
    );
  }
}
