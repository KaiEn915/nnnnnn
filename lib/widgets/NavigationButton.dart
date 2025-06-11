import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap; // 新增

  const NavigationButton({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 支持点击
      child: Container(
        width: 83,
        height: 58,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(),
        child: Stack(
          children: [
            Positioned(
              top: 25,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFDFDFDF)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      image: AssetImage("assets/images/home.png"),
                      width: 18,
                      height: 17,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      width: 41,
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF828282),
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 22,
              child: Image(
                image: AssetImage("assets/images/cat.png"),
                width: 39,
                height: 38,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



