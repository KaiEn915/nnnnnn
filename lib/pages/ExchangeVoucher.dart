import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/overlays/ExchangeVoucherOverlay.dart';
import 'package:gan/overlays/InsufficientPointOverlay.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:gan/utils/OurUI.dart';
import 'package:gan/widgets/OurFont.dart';
import 'package:gan/widgets/TopBar.dart';

class ExchangeVoucher extends StatefulWidget {
  const ExchangeVoucher({super.key});

  @override
  State<StatefulWidget> createState() => _ExchangeVoucherState();
}

class _ExchangeVoucherState extends State<ExchangeVoucher> {
  List<dynamic> ownedVouchers_id = [];

  bool isVoucherOwned(String id) {
    return ownedVouchers_id.contains(id);
  }

  @override
  void initState() {
    super.initState();

    loadOwnedVouchers();
  }

  Future<void> loadOwnedVouchers() async {
    final data = await AuthService.userDocRef.get();
    final snapshot = data.data();
    ownedVouchers_id = snapshot?['ownedVouchers_id'];
    for(int i=0;i<ownedVouchers_id.length;i++)
      print("owned: "+ownedVouchers_id[i]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: AuthService.userDocRef.get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data;

          return Container(
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
                  top: 350,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 500,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: AuthService.db
                          .collection('vouchers')
                          .orderBy('expiryTimestamp', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        final vouchers = snapshot.data!.docs;
                        if (vouchers.isEmpty) {
                          return Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              decoration: OurUI.shapeDecoration(
                                hasShadow: true,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: OurFont(text: "No vouchers found..."),
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,

                          padding: EdgeInsets.all(10),
                          itemCount: vouchers.length,
                          itemBuilder: (context, index) {
                            final title = vouchers[index]['title'];
                            final expiryDate =
                                DateTime.fromMillisecondsSinceEpoch(
                                  vouchers[index]['expiryTimestamp'],
                                );
                            final discountPercentage =
                                vouchers[index]['discountPercentage'];
                            final discountCap = vouchers[index]['discountCap'];
                            final requiredPoints =
                                vouchers[index]['requiredPoints'];
                            final _isVoucherOwned=isVoucherOwned(vouchers[index]['id']);

                            return Container(
                              height: 124,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFFFD3D3),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 0.50,
                                    color: Colors.white,
                                  ),
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
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 10,
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFD19F9C),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 93,
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
                                              spacing: 4,
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  height: 15.20,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 19,
                                                        height: 15,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage(
                                                              "assets/images/gift.png",
                                                            ),
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 66.18,
                                                        height: 15,
                                                        child: Text(
                                                          'DUE $expiryDate',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: const Color(
                                                              0xFFFF9191,
                                                            ),
                                                            fontSize: 10,
                                                            fontFamily:
                                                                'IBM Plex Sans',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            height: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 19,
                                                        height: 15,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage(
                                                              "assets/images/gift.png",
                                                            ),
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
                                                    title,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                      fontFamily:
                                                          'IBM Plex Sans',
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                                  width: 106,
                                                  child: Text(
                                                    '$discountPercentage% OFF',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(
                                                        0xFFFE0000,
                                                      ),
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'IBM Plex Sans',
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                                  width: 106,
                                                  child: Text(
                                                    'UP TO RM$discountCap',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(
                                                        0xFFFE6100,
                                                      ),
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'IBM Plex Sans',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 1,
                                                      shadows: [
                                                        Shadow(
                                                          offset: Offset(0, 4),
                                                          blurRadius: 4,
                                                          color: Color(
                                                            0xFF000000,
                                                          ).withAlpha(64),
                                                        ),
                                                      ],
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
                                    left: 360,
                                    child: Container(
                                      width: 30,
                                      height: 30,
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
                                  Positioned(
                                    left: 155,
                                    top: 20,
                                    child: Container(
                                      width: 165,
                                      height: 34,
                                      child: FittedBox(
                                        child: Text(
                                          "Price: $requiredPoints pts",
                                          style: TextStyle(
                                            fontFamily: 'Iceland',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    left: 175,
                                    top: 90,
                                    child: Container(
                                      transform: Matrix4.identity()
                                        ..scale(-1.0, 1.0),
                                      width: 60,
                                      height: 45,
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
                                  Positioned(
                                    left: 185,
                                    top: 70,
                                    child: Container(
                                      width: 120,
                                      height: 50,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 8,
                                            top: 5.48,
                                            child:
                                                GestureDetector(
                                                    onTap: () async {
                                                      if (_isVoucherOwned)
                                                        return;

                                                      int userPoints =
                                                          userData?['rewardPoints'];
                                                      if (userPoints >=
                                                          requiredPoints) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return ExchangeVoucherOverlay(
                                                              data:
                                                                  vouchers[index]
                                                                          .data()
                                                                      as Map<
                                                                        String,
                                                                        dynamic
                                                                      >,
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              true,
                                                          builder:
                                                              (
                                                                BuildContext
                                                                context,
                                                              ) {
                                                                return InsufficientPointOverlay();
                                                              },
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      height: 30,
                                                      decoration: ShapeDecoration(
                                                        color: _isVoucherOwned?Colors.grey:const Color(
                                                          0xFFC9A0A0,
                                                        ),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8,
                                                              ),
                                                        ),
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            left: 7,
                                                            top: 5,
                                                            child: SizedBox(
                                                              width: 89,
                                                              child: Text(
                                                                _isVoucherOwned?"Owned":'Exchange',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                  color: _isVoucherOwned?Colors.black:const Color(
                                                                    0xFF820000,
                                                                  ),
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  height: 1.40,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )

                                          ),
                                          Positioned(
                                            left: 45,
                                            top: -7.52,
                                            child: Container(
                                              width: 25,
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
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 240,
                  child: Container(
                    width: 350,
                    height: 80,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFE4FBFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 350,
                          height: 50,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/pointBackground.png",
                              ),
                              fit: BoxFit.cover,
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
                              ),
                            ],
                          ),
                          child: Row(
                            spacing: 10,
                            children: [
                              SizedBox(
                                width: 180,
                                height: 31,
                                child: Text(
                                  'Your Reward Point:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                width: 109,
                                height: 40,
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
                                  children: [
                                    SizedBox(
                                      width: 77,
                                      child: Text(
                                        "${userData?['rewardPoints']}",
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
                  header: 'VOUCHER CENTRE',
                  leftIcon: Icons.arrow_back,
                  leftIcon_onTap: () => {
                    Navigator.pushNamed(context, "/Voucher"),
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
