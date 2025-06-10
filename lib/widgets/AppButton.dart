import "package:flutter/material.dart";
class AppButton extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.text,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: ShapeDecoration(
          color: const Color(0xFF485266),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 8,
              offset: Offset(4, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}
