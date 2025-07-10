import 'package:flutter/material.dart';
import 'package:gan/widgets/AppButton.dart';

class InsufficientPointOverlay extends StatelessWidget {
  const InsufficientPointOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        height: 200,
        clipBehavior: Clip.none,
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
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 96,
                  padding: const EdgeInsets.all(20),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Oops, you don’t have enough points',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF780006),
                        fontSize: 20,
                        fontFamily: 'Iceland',
                        fontWeight: FontWeight.w400,
                        height: 1,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Color(0xFF000000).withOpacity(0.25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 71,
                  clipBehavior: Clip.none,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFDF9797),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.50),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child:GestureDetector(
                            onTap: (){Navigator.pop(context);},
                              child:Center(
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

                          )
  
                        ),
                        Positioned(
                          top: -15,
                          left:0,
                          right:0,
                          child: Image.asset(
                            "assets/images/cat.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  )

                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              top: -30,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/cat2.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
