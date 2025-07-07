import 'package:flutter/material.dart';

class VoucherOverlay extends StatelessWidget {
  const VoucherOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 349,
        padding: const EdgeInsets.all(10),
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
              spacing: 10,
              children: [
                // 顶部文字
                Container(
                  height: 96,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Scan the QR below to apply your voucher!',
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
                // 中部二维码
                Container(
                  width: 349,
                  height: 250,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    "assets/images/scan.png",
                    fit: BoxFit.contain,
                  ),
                ),

                Container(
                  width: 349,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: 103,
                          height: 51,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(top: 12),
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
                                'Back',
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
                ),
              ],
            ),

            // 顶部贴图图标
            Positioned(
              top: -35,
              left: 130,
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
