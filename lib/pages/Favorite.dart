import 'package:flutter/material.dart';
import 'package:gan/widgets/TopBar.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

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
                left: 1,
                top: 100,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 700,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 15,
                    children: [
                      Container(
                        width: 180,
                        height: 270,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0x7FCDFAFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 8.50,
                              top: 11,
                              child: Container(
                                width: 160,
                                height: 244,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Colors.white.withValues(alpha: 0.50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/images/cat.png"),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      height: 29,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Row(
                                        spacing: 5,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right:0),
                                            child: Icon(
                                                Icons.location_on,
                                                color: Colors.red,
                                                size: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 111,
                                            height: 29,
                                            child: Text(
                                              'Near',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: 150,
                                      height: 29,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 5),
                                            child: Icon(
                                                Icons.account_circle,
                                                size: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 111,
                                            height: 29,
                                            child: Text(
                                              'Posted by',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
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
                            ),
                            Positioned(
                              left: 140,
                              top: 225,
                              child: Container(
                                child: Icon(
                                  Icons.delete,
                                  size: 25,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 71,
                              top: 0,
                              child: Container(
                                width: 30,
                                height: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/love.png"),
                                    fit: BoxFit.contain,
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
              TopBar(
                isMiddleSearchBar: false,
                header: "FAVORITE POSTS",
                leftIcon: Icons.arrow_back,
                leftIcon_onTap: () => {
                  Navigator.pushNamed(context, "/UserProfile"),
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}