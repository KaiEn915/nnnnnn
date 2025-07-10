import 'package:flutter/material.dart';

class InsufficientPointOverlay extends StatelessWidget {
  const InsufficientPointOverlay({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
       child: Container(
          height: 500,
          padding: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.50, 1.00),
              end: Alignment(0.50, -0.00),
              colors: [const Color(0xFFFBD5FF), const Color(0xFFFFC9CA)],
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 3,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(15),
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
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 300,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
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
                        SizedBox(
                          width: 223,
                          height: 96,
                          child: Text(
                            'Oops, you don’t have enough points',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF780006),
                              fontSize: 20,
                              fontFamily: 'Iceland',
                              fontWeight: FontWeight.w400,
                              height: 1,
                              shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 25,
                      children: [
                        Container(
                          width: 103,
                          height: 51,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 2,
                                top: 12,
                                child: Container(
                                  width: 99,
                                  height: 35,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFDF9797),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 0.50),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          left: 33,
                                          top: 7.50,
                                          child: GestureDetector(
                                            onTap: (){Navigator.pop(context);},
                                            child: Text(
                                              'Back',
                                              style: TextStyle(
                                                color: const Color(0xFF560101),
                                                fontSize: 14,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                height: 1.40,
                                              ),
                                            ),
                                          )

                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 42,
                                top: 0,
                                child: Container(
                                  width: 19,
                                  height: 19,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage("https://placehold.co/19x19"),
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
                ],
              ),
              Positioned(
                left: 155,
                top: -20,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/cat3.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}