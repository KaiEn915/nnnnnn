import 'package:flutter/material.dart';
import 'package:gan/widgets/TopBar.dart';

class Voucher extends StatelessWidget {
  const Voucher({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 375,
          height: 684,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://placehold.co/375x684"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
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
                left: 19,
                top: 185,
                child: Container(
                  width: 336,
                  height: 482,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    runAlignment: WrapAlignment.start,
                    runSpacing: 0,
                    children: [
                      Container(
                        width: 154,
                        height: 194,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 6,
                              top: 5,
                              child: Container(
                                width: 139,
                                height: 184,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFBFFD0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 17,
                                      top: 10,
                                      child: Container(
                                        width: 105,
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
                                          spacing: 12,
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
                                              width: 105,
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
                                              width: 105,
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
                                              width: 105,
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
                                            Container(
                                              width: double.infinity,
                                              height: 44,
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
                                                        color: const Color(0xFFA0C9AF),
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
                                                            left: 0,
                                                            top: 5,
                                                            child: SizedBox(
                                                              width: 89,
                                                              child: Text(
                                                                'Use now!',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: const Color(0xFF145C00),
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
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: -1,
                                      top: 151,
                                      child: Container(
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
                            ),
                            Positioned(
                              left: 137,
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
                          ],
                        ),
                      ),
                      Container(
                        width: 154,
                        height: 194,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 6,
                              top: 5,
                              child: Container(
                                width: 139,
                                height: 184,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFBFFD0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 17,
                                      top: 10,
                                      child: Container(
                                        width: 105,
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
                                          spacing: 12,
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
                                                      'DUE 31/2/25',
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
                                              width: 105,
                                              child: Text(
                                                'DHANI PET STORE',
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
                                              width: 105,
                                              child: Text(
                                                '3% OFF ',
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
                                              width: 105,
                                              child: Text(
                                                'UP TO RM20',
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
                                            Container(
                                              width: double.infinity,
                                              height: 44,
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
                                                        color: const Color(0xFFA0C9AF),
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
                                                            left: 0,
                                                            top: 5,
                                                            child: SizedBox(
                                                              width: 89,
                                                              child: Text(
                                                                'Use now!',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: const Color(0xFF145C00),
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
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: -1,
                                      top: 151,
                                      child: Container(
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
                            ),
                            Positioned(
                              left: 137,
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
                          ],
                        ),
                      ),
                      Container(
                        width: 154,
                        height: 194,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 6,
                              top: 5,
                              child: Container(
                                width: 139,
                                height: 184,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFBFFD0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 17,
                                      top: 10,
                                      child: Container(
                                        width: 105,
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
                                          spacing: 12,
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
                                                      'DUE 5/5/25',
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
                                              width: 105,
                                              child: Text(
                                                'CM CATS MART',
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
                                              width: 105,
                                              child: Text(
                                                '10% OFF ',
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
                                              width: 105,
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
                                            Container(
                                              width: double.infinity,
                                              height: 44,
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
                                                        color: const Color(0xFFA0C9AF),
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
                                                            left: 0,
                                                            top: 5,
                                                            child: SizedBox(
                                                              width: 89,
                                                              child: Text(
                                                                'Use now!',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: const Color(0xFF145C00),
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
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: -1,
                                      top: 151,
                                      child: Container(
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
                            ),
                            Positioned(
                              left: 137,
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
                          ],
                        ),
                      ),
                      Container(
                        width: 154,
                        height: 194,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 6,
                              top: 5,
                              child: Container(
                                width: 139,
                                height: 184,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFBFFD0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 17,
                                      top: 10,
                                      child: Container(
                                        width: 105,
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
                                          spacing: 12,
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
                                              width: 105,
                                              child: Text(
                                                'SUC PET STORE',
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
                                              width: 105,
                                              child: Text(
                                                '10% OFF ',
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
                                              width: 105,
                                              child: Text(
                                                'UP TO RM10',
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
                                            Container(
                                              width: double.infinity,
                                              height: 44,
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
                                                        color: const Color(0xFFA0C9AF),
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
                                                            left: 0,
                                                            top: 5,
                                                            child: SizedBox(
                                                              width: 89,
                                                              child: Text(
                                                                'Use now!',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: const Color(0xFF145C00),
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
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: -1,
                                      top: 151,
                                      child: Container(
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
                            ),
                            Positioned(
                              left: 137,
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
                          ],
                        ),
                      ),
                      Container(
                        width: 154,
                        height: 194,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 6,
                              top: 5,
                              child: Container(
                                width: 139,
                                height: 184,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFBFFD0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 17,
                                      top: 10,
                                      child: Container(
                                        width: 105,
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
                                          spacing: 12,
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
                                                      'DUE 15/9/25',
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
                                              width: 105,
                                              child: Text(
                                                'GO PET SHOP',
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
                                              width: 105,
                                              child: Text(
                                                '99% OFF ',
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
                                              width: 105,
                                              child: Text(
                                                'UP TO RM3',
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
                                            Container(
                                              width: double.infinity,
                                              height: 44,
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
                                                        color: const Color(0xFFA0C9AF),
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
                                                            left: 0,
                                                            top: 5,
                                                            child: SizedBox(
                                                              width: 89,
                                                              child: Text(
                                                                'Use now!',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: const Color(0xFF145C00),
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
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: -1,
                                      top: 151,
                                      child: Container(
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
                            ),
                            Positioned(
                              left: 137,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TopBar(
                isMiddleSearchBar: false,
                header: 'YOUR VOUCHER',
                leftIcon: Icons.arrow_back,
                leftIcon_onTap: () => {
                  Navigator.pushNamed(context, "/UserProfile"),
                },
                rightIcon: Icons.discount,
                rightIcon_onTap: () => {
                  Navigator.pushNamed(context, "/ExchangeVoucher"),
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}