import 'package:flutter/material.dart';
class AppButton extends StatefulWidget {
  final String text;
  final double width;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.text,
    this.textColor=Colors.white,
    this.backgroundColor=const Color(0xFF485266),
    required this.width,
    required this.onPressed,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed, // Fix: Correct reference to the onPressed property
      child: Container(
        width: widget.width,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: ShapeDecoration(
          color: widget.backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadows: [
            BoxShadow(
              color: const Color(0x3F000000),
              blurRadius: 8,
              offset: const Offset(4, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            widget.text, // Fix: Correct reference to the text property
            style: TextStyle(
              color: widget.textColor,
              fontSize: 14,
              fontFamily: 'https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100..700;1,100..700&display=swap',
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}
