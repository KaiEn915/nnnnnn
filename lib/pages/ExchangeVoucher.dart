import 'package:flutter/material.dart';
import 'package:gan/widgets/TopBar.dart';

class ExchangeVoucher extends StatelessWidget {
  const ExchangeVoucher({super.key,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 375,
          height: 684,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 1,
                top: 0,
                child: Container(
                  width: 375,
                  height: 684,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 375,
                          height: 684,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://placehold.co/375x684"),
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
                left: 23,
                top: 264,
                child: Container(
                  width: 332,
                  height: 401,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Container(
                        width: 304,
                        height: 124,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFFD3D3),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 0.50, color: Colors.white),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 17,
                              top: 5,
                              child: Container(
                                width: 122,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFD19F9C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 93,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFFFFEF9),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        spacing: 4,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 15.20,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 19,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://placehold.co/19x15"),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 66.18,
                                                  height: 15,
                                                  child: Text(
                                                    'DUE 1/1/25',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(0xFFFF9191),
                                                      fontSize: 10,
                                                      fontFamily: 'IBM Plex Sans',
                                                      fontWeight: FontWeight.w700,
                                                      height: 1,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 19,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://placehold.co/19x15"),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 106,
                                            child: Text(
                                              'GARDEN PET SHOP',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w700,
                                                height: 1,
                                                shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 106,
                                            child: Text(
                                              '5% OFF ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color(0xFFFE0000),
                                                fontSize: 16,
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w700,
                                                height: 1,
                                                shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 106,
                                            child: Text(
                                              'UP TO RM5',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color(0xFFFE6100),
                                                fontSize: 16,
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w700,
                                                height: 1,
                                                shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
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
                              left: 287,
                              top: 0,
                              child: Container(
                                width: 17,
                                height: 18,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage("https://placehold.co/17x18"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 139,
                              top: 30,
                              child: SizedBox(
                                width: 165,
                                height: 34,
                                child: Text(
                                  'Price: 500pt',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontFamily: 'Iceland',
                                    fontWeight: FontWeight.w400,
                                    height: 1.40,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 169,
                              top: 70,
                              child: Container(
                                width: 105,
                                height: 38,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 8,
                                      top: 5.48,
                                      child: Container(
                                        width: 89,
                                        height: 27,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFC9A0A0),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              top: 5,
                                              child: SizedBox(
                                                width: 89,
                                                child: Text(
                                                  'Exchange',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: const Color(0xFF820000),
                                                    fontSize: 14,
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
                                    ),
                                    Positioned(
                                      left: 43,
                                      top: -7.52,
                                      child: Container(
                                        width: 19,
                                        height: 27,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage("https://placehold.co/19x27"),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 166,
                              top: 133,
                              child: Container(
                                transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                                width: 38,
                                height: 33,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage("https://placehold.co/38x33"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 304,
                        height: 124,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFFD3D3),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 0.50, color: Colors.white),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 17,
                              top: 5,
                              child: Container(
                                width: 122,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFD19F9C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 93,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFFFFEF9),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        spacing: 4,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 15.20,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 19,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://placehold.co/19x15"),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 66.18,
                                                  height: 15,
                                                  child: Text(
                                                    'DUE 1/1/26',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(0xFFFF9191),
                                                      fontSize: 10,
                                                      fontFamily: 'IBM Plex Sans',
                                                      fontWeight: FontWeight.w700,
                                                      height: 1,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 19,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://placehold.co/19x15"),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 106,
                                            child: Text(
                                              'FAIRY PET STORE',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w700,
                                                height: 1,
                                                shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 106,
                                            child: Text(
                                              '1% OFF ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color(0xFFFE0000),
                                                fontSize: 16,
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w700,
                                                height: 1,
                                                shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 106,
                                            child: Text(
                                              'UP TO RM5',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color(0xFFFE6100),
                                                fontSize: 16,
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w700,
                                                height: 1,
                                                shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
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
                              left: 287,
                              top: 0,
                              child: Container(
                                width: 17,
                                height: 18,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage("https://placehold.co/17x18"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 139,
                              top: 30,
                              child: SizedBox(
                                width: 165,
                                height: 34,
                                child: Text(
                                  'Price: 1000pt',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontFamily: 'Iceland',
                                    fontWeight: FontWeight.w400,
                                    height: 1.40,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 169,
                              top: 70,
                              child: Container(
                                width: 105,
                                height: 38,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 8,
                                      top: 5.48,
                                      child: Container(
                                        width: 89,
                                        height: 27,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFC9A0A0),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              top: 5,
                                              child: SizedBox(
                                                width: 89,
                                                child: Text(
                                                  'Exchange',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: const Color(0xFF820000),
                                                    fontSize: 14,
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
                                    ),
                                    Positioned(
                                      left: 43,
                                      top: -7.52,
                                      child: Container(
                                        width: 19,
                                        height: 27,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage("https://placehold.co/19x27"),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 166,
                              top: 133,
                              child: Container(
                                transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                                width: 38,
                                height: 33,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage("https://placehold.co/38x33"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 304,
                        height: 124,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFFD3D3),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 0.50, color: Colors.white),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 17,
                              top: 5,
                              child: Container(
                                width: 122,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFD19F9C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 93,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFFFFEF9),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        spacing: 4,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 15.20,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 19,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://placehold.co/19x15"),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 66.18,
                                                  height: 15,
                                                  child: Text(
                                                    'DUE 1/1/27',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(0xFFFF9191),
                                                      fontSize: 10,
                                                      fontFamily: 'IBM Plex Sans',
                                                      fontWeight: FontWeight.w700,
                                                      height: 1,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 19,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://placehold.co/19x15"),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 106,
                                            child: Text(
                                              'HEAVEN PETSHOP',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w700,
                                                height: 1,
                                                shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 106,
                                            child: Text(
                                              '5% OFF ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color(0xFFFE0000),
                                                fontSize: 16,
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w700,
                                                height: 1,
                                                shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 106,
                                            child: Text(
                                              'UP TO RM5',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color(0xFFFE6100),
                                                fontSize: 16,
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w700,
                                                height: 1,
                                                shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
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
                              left: 287,
                              top: 0,
                              child: Container(
                                width: 17,
                                height: 18,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage("https://placehold.co/17x18"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 139,
                              top: 30,
                              child: SizedBox(
                                width: 165,
                                height: 34,
                                child: Text(
                                  'Price: 2000pt',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontFamily: 'Iceland',
                                    fontWeight: FontWeight.w400,
                                    height: 1.40,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 169,
                              top: 70,
                              child: Container(
                                width: 105,
                                height: 38,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 8,
                                      top: 5.48,
                                      child: Container(
                                        width: 89,
                                        height: 27,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFC9A0A0),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              top: 5,
                                              child: SizedBox(
                                                width: 89,
                                                child: Text(
                                                  'Exchange',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: const Color(0xFF820000),
                                                    fontSize: 14,
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
                                    ),
                                    Positioned(
                                      left: 43,
                                      top: -7.52,
                                      child: Container(
                                        width: 19,
                                        height: 27,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage("https://placehold.co/19x27"),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 166,
                              top: 133,
                              child: Container(
                                transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                                width: 38,
                                height: 33,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage("https://placehold.co/38x33"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 304,
                        height: 124,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFFD3D3),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 0.50, color: Colors.white),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 17,
                              top: 5,
                              child: Container(
                                width: 122,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFD19F9C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 93,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFFFFEF9),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        spacing: 4,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 15.20,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 19,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://placehold.co/19x15"),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 66.18,
                                                  height: 15,
                                                  child: Text(
                                                    'DUE 1/1/28',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(0xFFFF9191),
                                                      fontSize: 10,
                                                      fontFamily: 'IBM Plex Sans',
                                                      fontWeight: FontWeight.w700,
                                                      height: 1,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 19,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://placehold.co/19x15"),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 106,
                                            child: Text(
                                              'QIANG PET SHOP',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w700,
                                                height: 1,
                                                shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 106,
                                            child: Text(
                                              '80% OFF ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color(0xFFFE0000),
                                                fontSize: 16,
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w700,
                                                height: 1,
                                                shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 106,
                                            child: Text(
                                              'UP TO RM5',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color(0xFFFE6100),
                                                fontSize: 16,
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w700,
                                                height: 1,
                                                shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
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
                              left: 287,
                              top: 0,
                              child: Container(
                                width: 17,
                                height: 18,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage("https://placehold.co/17x18"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 139,
                              top: 30,
                              child: SizedBox(
                                width: 165,
                                height: 34,
                                child: Text(
                                  'Price: 5000pt',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontFamily: 'Iceland',
                                    fontWeight: FontWeight.w400,
                                    height: 1.40,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 169,
                              top: 70,
                              child: Container(
                                width: 105,
                                height: 38,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 8,
                                      top: 5.48,
                                      child: Container(
                                        width: 89,
                                        height: 27,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFC9A0A0),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              top: 5,
                                              child: SizedBox(
                                                width: 89,
                                                child: Text(
                                                  'Exchange',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: const Color(0xFF820000),
                                                    fontSize: 14,
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
                                    ),
                                    Positioned(
                                      left: 43,
                                      top: -7.52,
                                      child: Container(
                                        width: 19,
                                        height: 27,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage("https://placehold.co/19x27"),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 166,
                              top: 133,
                              child: Container(
                                transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                                width: 38,
                                height: 33,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage("https://placehold.co/38x33"),
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
              Positioned(
                left: 22,
                top: 188,
                child: Container(
                  width: 332,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE4FBFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage("https://placehold.co/302x37"),
                            fit: BoxFit.none,
                          ),
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 154,
                              height: 31,
                              child: Text(
                                'Your Reward Point:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  height: 1.40,
                                ),
                              ),
                            ),
                            Container(
                              width: 109,
                              height: 31,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                                    width: 77,
                                    child: Text(
                                      '1487',
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
             TopBar(
               isMiddleSearchBar: false,
               header: 'VOUCHER CENTRA',
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