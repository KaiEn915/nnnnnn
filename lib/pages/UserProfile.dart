import 'package:flutter/material.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/widgets/MyNavigationBar.dart';
import 'package:gan/widgets/TopBar.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

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
                left: 20,
                top: 110,
                child: Container(
                  width: 370,
                  height: 450,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white.withAlpha(5),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 40,
                    children: [
                      Container(
                        width: 255,
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 160,
                              child: Center(
                                child: Text(
                                  '@kiatmeng0101',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF828282),
                                    fontSize: 17,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 1.40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white.withAlpha(100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 117,
                              height: 118,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/cat.png"),
                                  fit: BoxFit.contain,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 270,
                        height: 67,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/Cloud.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 5,
                          ),
                          child: Text(
                            AuthService.userData?['username'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontFamily: 'Iceland',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                              letterSpacing: -0.32,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          'Hello guys i love pet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 1.50,
                            letterSpacing: -0.15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MyNavigationBar(),
              Positioned(
                left: 21,
                top: 600,
                child: Container(
                  width: 370,
                  height: 150,
                  decoration: ShapeDecoration(
                    color: const Color(0xBFECFFFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 10,
                        top: 17,
                        child: Container(
                          width: 350,
                          height: 115,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/PutButton.png"),
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 80,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "assets/images/ticket.png",
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xBFFFFFFF),
                                            blurRadius: 4,
                                            offset: Offset(0, 4),
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      child: Icon(Icons.bookmark, size: 40),
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
              ),
              Positioned(
                left: 175,
                top: 574,
                child: Container(
                  width: 58,
                  height: 44,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/cat2.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
             TopBar(
               isMiddleSearchBar: false,
               header: "PROFILE",
               rightIcon: Icons.settings_outlined,
               rightIcon_onTap: ()=> {Navigator.pushNamed(context, "/Setting")},
             ),
            ],
          ),
        ),
      ],
    );
  }
}
