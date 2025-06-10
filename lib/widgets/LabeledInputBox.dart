import 'package:flutter/material.dart';
class LabeledInputBox extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool hasBackground;

  const LabeledInputBox({
    super.key,
    required this.label,
    required this.placeholder,
    required this.hasBackground
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 75,
      clipBehavior: Clip.antiAlias,

      decoration: hasBackground
          ? const BoxDecoration(
        color: Colors.blue,
      )
          : const BoxDecoration(),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 13,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.40,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 35,
            child: Container(
              width: 327,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    placeholder,
                    style: const TextStyle(
                      color: Color(0xFF828282),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.40,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 262,
            top: -3,
            child: Image.asset(
              'assets/images/cat.png',
              width: 50,
            ),
          ),
        ],
      ),
    );
  }
}
