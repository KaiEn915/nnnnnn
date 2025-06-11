import 'package:flutter/material.dart';
import 'package:gan/pages/GroupChat.dart';
import 'package:gan/widgets/HomePost.dart';
import 'package:gan/widgets/NavigationButton.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                bottom: 0,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE0FBFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BottomButton(
                        label: 'Home',
                        iconImage: AssetImage("assets/images/cat.png"),
                        overlayImage: AssetImage("assets/images/home.png"),
                        leftOffset: -0.5,
                        topOffset: 25,
                        iconSize: Size(39, 38),
                        labelWidth: 41,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Home()),
                          );
                        },
                      ),
                      BottomButton(
                        label: 'Chats',
                        iconImage: AssetImage("assets/images/cat.png"),
                        overlayImage: AssetImage("assets/images/home.png"),
                        leftOffset: -0.5,
                        topOffset: 25,
                        iconSize: Size(39, 38),
                        labelWidth: 41,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const GroupChat()),
                          );// 跳转到 Chats 页面
                        },
                      ),
                      BottomButton(
                        label: 'Profile',
                        iconImage: AssetImage("assets/images/cat.png"),
                        overlayImage: AssetImage("assets/images/home.png"),
                        leftOffset: 0.5,
                        topOffset: 25,
                        iconSize: Size(39, 38),
                        labelWidth: 41,
                        onTap: () {
                          // 跳转到 Profile 页面
                        },
                      ),
                      BottomButton(
                        label: 'Scan',
                        iconImage: AssetImage("assets/images/cat.png"),
                        overlayImage: AssetImage("assets/images/home.png"),
                        leftOffset: -0.5,
                        topOffset: 25,
                        iconSize: Size(39, 38),
                        labelWidth: 41,
                        onTap: () {
                          // 跳转到 Scan 页面
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                //里面的边框
                left: 0,
                top: 96,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 760,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.red),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20,
                    children: [
                      //post里面的东西
                      HomePost(),
                      HomePost()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                child: Container(
                  //search box table
                  width: MediaQuery.sizeOf(context).width,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  // margin: const EdgeInsets.symmetric(horizontal: 15),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white.withAlpha(192),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Container(
                        width: 37,
                        height: 37,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
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
                        child: Stack(),
                      ),
                      Container(
                        width: 244,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 9,
                        ),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 15,
                          children: [
                            Container(
                              width: 178,
                              height: 31,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: const Color(0xFFDFDFDF),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 10,
                                children: [
                                  SizedBox(
                                    width: 146,
                                    child: Text(
                                      'Search post...',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xFF828282),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 1.40,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 26,
                              height: 31,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://placehold.co/26x31",
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 37,
                        height: 37,
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
                        child: Stack(
                          children: [
                            Positioned(
                              left: 7,
                              top: 7,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "https://placehold.co/24x24",
                                    ),
                                    fit: BoxFit.cover,
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
            ],
          ),
        ),
      ],
    );
  }
}
