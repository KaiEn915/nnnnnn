import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/pages/Voucher.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/NavigatorService.dart';

class ExchangeVoucherOverlay extends StatelessWidget {
  final Map<String, dynamic> data;

  const ExchangeVoucherOverlay({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 400,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xFFFBD5FF), Color(0xFFFFC9CA)],
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 3, color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 96,
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Do you really want to exchange for this voucher?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF780006),
                        fontSize: 20,
                        fontFamily: 'Iceland',
                        height: 1.2,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Color(0x40000000),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 70,
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(); // 关闭窗口
                      },
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            width: 103,
                            height: 51,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(top: 12),
                              width: 99,
                              height: 35,
                              decoration: ShapeDecoration(
                                color: Color(0xFFDF9797),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(width: 0.5),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'No',
                                  style: TextStyle(
                                    color: Color(0xFF560101),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -2,
                            child: Image.asset(
                              "assets/images/cat.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Yes Button
                    GestureDetector(
                      onTap: () async{

                        final doc=await AuthService.userDocRef.get();
                        final snapshot=doc.data();
                        int userPoints=snapshot?['rewardPoints']??0;

                        int requiredPoints=data['requiredPoints'];

                        await AuthService.userDocRef.update({"rewardPoints":userPoints-requiredPoints});
                        Fluttertoast.showToast(msg: '$requiredPoints points removed from your balance');

                        await AuthService.userDocRef.update({"ownedVouchers_id":FieldValue.arrayUnion([data['id']])});
                        Fluttertoast.showToast(msg: "Voucher exchanged successfully!");

                        Navigator.of(context).pop(); // 先关闭 Dialog
                        NavigatorService.openPage(Voucher(), context, true);

                      },
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            width: 103,
                            height: 51,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(top: 12),
                              width: 99,
                              height: 35,
                              decoration: ShapeDecoration(
                                color: Color(0xFF97DFA9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(width: 0.5),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: Color(0xFF015620),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -2,
                            child: Image.asset(
                              "assets/images/cat.png",
                              width: 30,
                              height: 30,
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
            // 上方贴图
            Positioned(
              top: -30,
              left: 130, // 水平居中
              child: Image.asset(
                "assets/images/cat2.png",
                width: 50,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}