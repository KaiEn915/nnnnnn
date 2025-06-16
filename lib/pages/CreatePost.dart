import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget{
  const CreatePost({super.key});

  @override
  State<StatefulWidget> createState()=>_CreatePost();
}


class _CreatePost extends State<CreatePost>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/background2.png"),fit: BoxFit.cover)
          ),
          child: Stack(
            children: [
              Positioned(
                left: 110,
                top: 599,
                child: Container(
                  width: 161,
                  height: 41,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    children: [
                      Text(
                        'Post',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 93,
                child: Container(
                  width: 316,
                  height: 471,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/316x471"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 16,
                        top: 215,
                        child: SizedBox(
                          width: 316,
                          height: 28,
                          child: Text(
                            'Title：',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.50,
                              letterSpacing: -0.20,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 14,
                        top: 244,
                        child: SizedBox(
                          width: 316,
                          height: 22,
                          child: Text(
                            'My pet have been lost ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.50,
                              letterSpacing: -0.12,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 269,
                        child: SizedBox(
                          width: 316,
                          height: 10,
                          child: Text(
                            '_____________________________________________',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.50,
                              letterSpacing: -0.15,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 289,
                        child: SizedBox(
                          width: 316,
                          height: 19,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Location',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 1.50,
                                    letterSpacing: -0.20,
                                  ),
                                ),
                                TextSpan(
                                  text: ':',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 1.50,
                                    letterSpacing: -0.25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 14,
                        top: 308,
                        child: SizedBox(
                          width: 316,
                          height: 21,
                          child: Text(
                            'Southern University College',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.50,
                              letterSpacing: -0.12,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 332,
                        child: SizedBox(
                          width: 316,
                          height: 10,
                          child: Text(
                            '_____________________________________________',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.50,
                              letterSpacing: -0.15,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 342,
                        child: SizedBox(
                          width: 316,
                          height: 27,
                          child: Text(
                            'Description:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.50,
                              letterSpacing: -0.20,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 14,
                        top: 369,
                        child: SizedBox(
                          width: 316,
                          height: 26,
                          child: Text(
                            '不喜欢design啦',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.50,
                              letterSpacing: -0.12,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 395,
                        child: SizedBox(
                          width: 316,
                          height: 26,
                          child: Text(
                            '我也是啦',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.50,
                              letterSpacing: -0.12,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 54,
                        top: 24,
                        child: Container(
                          width: 207,
                          height: 194,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://placehold.co/207x194"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 226,
                        top: 176,
                        child: Container(
                          width: 35,
                          height: 39,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://placehold.co/35x39"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 174,
                        top: 311,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://placehold.co/18x18"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 7.50,
                top: 16,
                child: Container(
                  width: 360,
                  height: 65,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white.withValues(alpha: 191),
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
                            )
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
                                    image: NetworkImage("https://placehold.co/24x24"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 244,
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
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 48,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: SizedBox(
                                      width: 244,
                                      height: 48,
                                      child: Text(
                                        'CREATE POST',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontFamily: 'IBM Plex Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 1,
                                          letterSpacing: 3.30,
                                          shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
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
                            )
                          ],
                        ),
                        child: Stack(),
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