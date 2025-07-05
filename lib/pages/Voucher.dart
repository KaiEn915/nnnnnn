import 'package:flutter/material.dart';
import 'package:gan/pages/VoucherOverlay.dart';
import 'package:gan/widgets/TopBar.dart';

class Voucher extends StatelessWidget {
  const Voucher({super.key});

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
              image: AssetImage("assets/images/background3.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 250,
                child: Container(
                  margin: EdgeInsetsGeometry.only(left: 10),
                  width: 392,
                  height: 600,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: SingleChildScrollView(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 20,
                      spacing: 20,
                      children: [
                        Container(
                          width: 165,
                          height: 200,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 6,
                                top: 5,
                                child: Container(
                                  width: 150,
                                  height: 195,
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
                                        left: 16,
                                        top: 17,
                                        child: Container(
                                          width: 120,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFFFFFEF9),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            spacing: 12,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(),
                                                child: Row(
                                                  children: [
                                                    Positioned(
                                                      child: Container(
                                                        width: 25,
                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage(
                                                              "assets/images/gift.png",
                                                            ),
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 66.18,
                                                      height: 15,
                                                      child: Text(
                                                        'DUE 1/1/25',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: const Color(
                                                            0xFFFF9191,
                                                          ),
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'IBM Plex Sans',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          height: 1,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      child: Container(
                                                        width: 25,
                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage(
                                                              "assets/images/gift.png",
                                                            ),
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 120,
                                                child: Text(
                                                  'GARDEN PET SHOP',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontFamily: 'IBM Plex Sans',
                                                    fontWeight: FontWeight.w700,
                                                    height: 1,
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
                                              SizedBox(
                                                width: 120,
                                                child: Text(
                                                  '5% OFF ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: const Color(
                                                      0xFFFE0000,
                                                    ),
                                                    fontSize: 16,
                                                    fontFamily: 'IBM Plex Sans',
                                                    fontWeight: FontWeight.w700,
                                                    height: 1,
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
                                              SizedBox(
                                                width: 120,
                                                child: Text(
                                                  'UP TO RM5',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: const Color(
                                                      0xFFFE6100,
                                                    ),
                                                    fontSize: 16,
                                                    fontFamily: 'IBM Plex Sans',
                                                    fontWeight: FontWeight.w700,
                                                    height: 1,
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
                                              Container(
                                                width: double.infinity,
                                                height: 44,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(),
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 16,
                                                      top: 5.48,
                                                      child:GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                            context:
                                                            context,
                                                            barrierDismissible:
                                                            true,
                                                            builder:
                                                                (
                                                                BuildContext
                                                                context,
                                                                ) {
                                                              return const VoucherOverlay();
                                                            },
                                                          );
                                                        },
                                                        child:Container(
                                                        width: 89,
                                                        height: 27,
                                                        decoration: ShapeDecoration(
                                                          color: const Color(
                                                            0xFFA0C9AF,
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              width: 1,
                                                              color:
                                                              const Color(
                                                                0xFFDFDFDF,
                                                              ),
                                                            ),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
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
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style: TextStyle(
                                                                    color: const Color(
                                                                      0xFF145C00,
                                                                    ),
                                                                    fontSize:
                                                                    14,
                                                                    fontFamily:
                                                                    'Inter',
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                    height:
                                                                    1.40,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 52,
                                                      top: -7.52,
                                                      child: Container(
                                                        width: 19,
                                                        height: 27,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage(
                                                              "assets/images/cat.png",
                                                            ),
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
                                        left: -10,
                                        top: 151,
                                        child: Container(
                                          width: 65,
                                          height: 65,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                "assets/images/Cat3.png",
                                              ),
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
                                left: 140,
                                top: 0,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/pin.png",
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
