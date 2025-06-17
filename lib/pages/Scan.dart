import 'package:flutter/material.dart';
import 'package:gan/widgets/TopBar.dart';

class Scan extends StatelessWidget {
  const Scan({super.key});

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
                left: 10,
                top: 133,
                child: Container(
                  //里面透明的
                  width: 392,
                  height: 392,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 15,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white.withAlpha(70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3FBCBCBC),
                        blurRadius: 4,
                        offset: Offset(0, 5),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 347,
                        height: 348,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/cat.png"),
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 165,
                top: 100,
                child: Container(
                  width: 70,
                  height: 75,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/love.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                //下面透明的
                left: 0,
                top: 820,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: const Color(0xBFDEDEDE)),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          child: Stack(
                            children: [
                              Positioned(
                                left: 70,
                                top: 15,
                                child: Container(
                                  width: 270,
                                  height: 70,
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
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 15,
                                        top: 8,
                                        child: Icon(
                                            Icons.upload,
                                                size: 50,
                                        ),
                                      ),
                                      Positioned(
                                        left: 80,
                                        top: 5,
                                        child: SizedBox(
                                          width: 170,
                                          height: 80,
                                          child: Text(
                                            'Upload',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: const Color(0xFF828282),
                                              fontSize: 35,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              height: 1.40,
                                            ),
                                          ),
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
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 620,
                child: Container(
                  width: 300,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 105,
                        top: 12,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 80,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 280,
                top: 460,
                child: Container(
                  width: 140,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/cat.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 560,
                child: Container(
                  width: 150,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Cat3.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              TopBar(
                isMiddleSearchBar: false,
                header: "TAKE A PICTURE",
                leftIcon: Icons.arrow_back,
                leftIcon_onTap: ()=> {Navigator.pop(context)},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
