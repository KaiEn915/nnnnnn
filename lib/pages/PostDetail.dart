import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/widgets/AppButton.dart';
import 'package:gan/widgets/TopBar.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({super.key, required this.postData});

  final Map<String, dynamic> postData;

  bool get isOwner => postData['uid'] == AuthService.uid;

  Future<void> deletePost(BuildContext context) async {
    await AuthService.db.collection("posts").doc(postData['post_id']).delete();

    Navigator.pop(context, "postDeleted");
    Fluttertoast.showToast(msg: "Post deleted successfully");
  }

  Future<void> createGroupChat(BuildContext context,String title, String description) async {
    final data = {
      "owner_uid": AuthService.uid,
      "members_uid": [AuthService.uid],
      "post_id": postData['id'],
      "title": title,
      "description": description,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    };

    final ref = await AuthService.db.collection('groupChats').add(data);
    await ref.update({"id": ref.id});

    AuthService.joinGroupChat(ref.id);

    Fluttertoast.showToast(msg: "Group chat created successfully");
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(color: Colors.white),

      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: AppButton(
              text: "Create Group Chat",
              onPressed: () async {
                await createGroupChat(context,"${postData['title']}'s Group Chat", "${postData['description']}");
              },
            ),
          ),

          Positioned(
            top: 100,
            child: Column(
              spacing: 10,
              children: [
                Positioned(
                  left: 1,
                  top: 81,
                  child: Container(
                    width: 374,
                    height: 600,
                    padding: const EdgeInsets.only(top: 10, bottom: 12),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Container(
                                width: 138,
                                height: 132,
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
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    Container(
                                      width: 190,
                                      height: 147,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            "https://placehold.co/190x147",
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 342,
                          height: 215,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 13,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xBFE5F9FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 2,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 23,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 21,
                                      height: 23,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            "https://placehold.co/21x23",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 353,
                                      height: 23,
                                      child: Text(
                                        '  Near Southern University College\n',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 26,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 21,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            "https://placehold.co/21x26",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 353,
                                      height: 26,
                                      child: Text(
                                        '  Since 7 hours before',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 26,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 21,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            "https://placehold.co/21x26",
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 353,
                                      height: 26,
                                      child: Text(
                                        '  +6012 3456 7890',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 26,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 21,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            "https://placehold.co/21x26",
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 353,
                                      height: 26,
                                      child: Text(
                                        '  kiatmeng0101@gmail.com',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 26,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 21,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            "https://placehold.co/21x26",
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 353,
                                      height: 26,
                                      child: Text(
                                        '  km_0101',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 65,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  runAlignment: WrapAlignment.start,
                                  runSpacing: 0,
                                  children: [
                                    Container(
                                      width: 21,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            "https://placehold.co/21x26",
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 300,
                                      height: 29,
                                      child: Text(
                                        '  About my pet:',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 321,
                                      height: 35,
                                      child: Text(
                                        'My pet Chan Wei Er has been missing since November!!! It is a German Shepherd Dog,',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 342,
                          height: 153,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xBFE1F9FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 9,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 32,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: SizedBox(
                                        width: 302,
                                        height: 32,
                                        child: Text(
                                          'COMMENTS',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: 'IBM Plex Sans',
                                            fontWeight: FontWeight.w700,
                                            height: 1,
                                            letterSpacing: 2.40,
                                            shadows: [
                                              Shadow(
                                                offset: Offset(0, 4),
                                                blurRadius: 4,
                                                color: Color(
                                                  0xFF000000,
                                                ).withOpacity(0.25),
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
                                width: double.infinity,
                                height: 99,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    Container(
                                      width: 302,
                                      height: 32,
                                      decoration: ShapeDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 128,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 31,
                                            top: 0,
                                            child: Container(
                                              width: 271,
                                              height: 32,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left: 2,
                                                    top: 0,
                                                    child: SizedBox(
                                                      width: 269,
                                                      height: 14,
                                                      child: Text(
                                                        '  Chok Yun Ying',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontFamily: 'Iceland',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.40,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 2,
                                                    top: 14,
                                                    child: SizedBox(
                                                      width: 269,
                                                      height: 14,
                                                      child: Text(
                                                        '  Don’t give up living!',
                                                        style: TextStyle(
                                                          color: const Color(
                                                            0xFF828282,
                                                          ),
                                                          fontSize: 12,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.40,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              width: 32,
                                              height: 32,
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
                                                      BorderRadius.circular(
                                                        100,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 302,
                                      height: 32,
                                      decoration: ShapeDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 128,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 31,
                                            top: 0,
                                            child: Container(
                                              width: 271,
                                              height: 32,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left: 2,
                                                    top: 0,
                                                    child: SizedBox(
                                                      width: 269,
                                                      height: 14,
                                                      child: Text(
                                                        '  Lee Chong Wei',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontFamily: 'Iceland',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.40,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 2,
                                                    top: 14,
                                                    child: SizedBox(
                                                      width: 269,
                                                      height: 14,
                                                      child: Text(
                                                        '  I saw your dog under my racket~',
                                                        style: TextStyle(
                                                          color: const Color(
                                                            0xFF828282,
                                                          ),
                                                          fontSize: 12,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.40,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              width: 32,
                                              height: 32,
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
                                                      BorderRadius.circular(
                                                        100,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 302,
                                      height: 32,
                                      decoration: ShapeDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 128,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 31,
                                            top: 0,
                                            child: Container(
                                              width: 271,
                                              height: 32,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left: 2,
                                                    top: 0,
                                                    child: SizedBox(
                                                      width: 269,
                                                      height: 14,
                                                      child: Text(
                                                        '  Doraemon',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontFamily: 'Iceland',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.40,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 2,
                                                    top: 14,
                                                    child: SizedBox(
                                                      width: 269,
                                                      height: 14,
                                                      child: Text(
                                                        '  Your dog inside my pocket',
                                                        style: TextStyle(
                                                          color: const Color(
                                                            0xFF828282,
                                                          ),
                                                          fontSize: 12,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.40,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              width: 32,
                                              height: 32,
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
                                                      BorderRadius.circular(
                                                        100,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 302,
                                      height: 32,
                                      decoration: ShapeDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 128,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 31,
                                            top: 0,
                                            child: Container(
                                              width: 271,
                                              height: 32,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left: 2,
                                                    top: 0,
                                                    child: SizedBox(
                                                      width: 269,
                                                      height: 14,
                                                      child: Text(
                                                        '  Pocket',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontFamily: 'Iceland',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.40,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 2,
                                                    top: 14,
                                                    child: SizedBox(
                                                      width: 269,
                                                      height: 14,
                                                      child: Text(
                                                        '  I got your dog',
                                                        style: TextStyle(
                                                          color: const Color(
                                                            0xFF828282,
                                                          ),
                                                          fontSize: 12,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.40,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              width: 32,
                                              height: 32,
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
                                                      BorderRadius.circular(
                                                        100,
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
                            ],
                          ),
                        ),
                        Container(
                          width: 342,
                          height: 37,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white.withValues(alpha: 128),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 15,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "https://placehold.co/30x30",
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "https://placehold.co/30x30",
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "https://placehold.co/30x30",
                                    ),
                                    fit: BoxFit.contain,
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
              ],
            ),
          ),
          TopBar(
            isMiddleSearchBar: false,
            header: postData['title'],
            leftIcon: Icons.arrow_back,
            leftIcon_onTap: () {
              Navigator.pop(context);
            },
            rightIcon: isOwner ? Icons.delete : null,
            rightIcon_onTap: () {
              deletePost(context);
            },
          ),
        ],
      ),
    );
  }
}
