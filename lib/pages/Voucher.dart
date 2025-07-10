import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gan/overlays/VoucherOverlay.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/utils/OurUI.dart';
import 'package:gan/widgets/OurFont.dart';
import 'package:gan/widgets/TopBar.dart';

class Voucher extends StatefulWidget {
  const Voucher({super.key});

  @override
  State<Voucher> createState() => _addVoucher();
}

class _addVoucher extends State<Voucher> {
  late final dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = AuthService.db.collection("users").doc(AuthService.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery
              .sizeOf(context)
              .width,
          height: MediaQuery
              .sizeOf(context)
              .height,
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
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(),
                  child: FutureBuilder(
                    future: AuthService.userDocRef.get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      List<dynamic> ownedVouchers_id = snapshot
                          .data?['ownedVouchers_id'];
                      if (ownedVouchers_id.isEmpty) {
                        return Center(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                decoration: OurUI.shapeDecoration(),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: OurFont(
                                      text: "You don't have any vouchers... go exchange one!"),
                                )

                            )

                        );
                      }

                      final voucherRef = AuthService.db.collection('vouchers');
                      final voucherFutures = ownedVouchers_id.map((id) =>
                          voucherRef.doc(id).get());

                      return FutureBuilder<List<DocumentSnapshot>>(
                          future: Future.wait(voucherFutures),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            final vouchers = snapshot.data!;
                            return SingleChildScrollView(
                              clipBehavior: Clip.none,
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                runSpacing: 20,
                                spacing: 20,
                                clipBehavior: Clip.none,
                                children: vouchers.map((voucher) {
                                  final title = voucher['title'];
                                  final discountPercentage =
                                  voucher['discountPercentage'];
                                  final discountCap = voucher['discountCap'];
                                  final expiryTimestamp = voucher['expiryTimestamp'];
                                  final expiryDate =
                                  DateTime.fromMillisecondsSinceEpoch(
                                    expiryTimestamp,
                                  );
                                  final formattedExpiry =
                                      'DUE${expiryDate.day}/${expiryDate
                                      .month}/${expiryDate.year}';

                                  return Container(
                                    width: 170,
                                    clipBehavior: Clip.none,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFFBFFD0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Stack(
                                      clipBehavior: Clip.none, // allows the cat image to overflow
                                      children: [
                                        // Main card
                                        Center(
                                          child:Container(
                                            margin:EdgeInsets.all(15),
                                            padding:EdgeInsets.all(5),
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFFFFEF9),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              shadows: [
                                                BoxShadow(
                                                  color: Color(0x3F000000),
                                                  blurRadius: 4,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              spacing: 10,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Image.asset("assets/images/gift.png", width: 20, height: 20),
                                                    Text(
                                                      formattedExpiry,
                                                      style: TextStyle(
                                                        color: Color(0xFFFF9191),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w700,
                                                        decoration: TextDecoration.none,
                                                      ),
                                                    ),
                                                    Image.asset("assets/images/gift.png", width: 20, height: 20),
                                                  ],
                                                ),

                                                Text(
                                                  title,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),

                                                Text(
                                                  '$discountPercentage% OFF',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFFE0000),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),

                                                Text(
                                                  'UP TO RM$discountCap',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFFE6100),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),

                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      builder: (BuildContext context) {
                                                        return const VoucherOverlay();
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 89,
                                                    height: 27,
                                                    decoration: ShapeDecoration(
                                                      color: const Color(0xFFA0C9AF),
                                                      shape: RoundedRectangleBorder(
                                                        side: BorderSide(
                                                          width: 1,
                                                          color: Color(0xFFDFDFDF),
                                                        ),
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Use now!',
                                                        style: TextStyle(
                                                          color: const Color(0xFF145C00),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                          decoration: TextDecoration.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        // Pin icon on top
                                        Positioned(
                                          top: -5,
                                          right: -5,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            clipBehavior: Clip.none,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/images/pin.png"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),

                                        // Cat image at bottom left corner
                                        Positioned(
                                          left: -15,
                                          bottom: -15,
                                          child: Container(
                                            width: 65,
                                            height: 65,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/images/Cat3.png"),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );

                                }).toList(),
                              ),
                            );
                          }
                      );
                    },
                  ),
                ),
              ),

              TopBar(
                isMiddleSearchBar: false,
                header: 'YOUR VOUCHER',
                leftIcon: Icons.arrow_back,
                leftIcon_onTap: () =>
                {
                  Navigator.pushNamed(context, "/UserProfile"),
                },
                rightIcon: Icons.discount,
                rightIcon_onTap: () =>
                {
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
