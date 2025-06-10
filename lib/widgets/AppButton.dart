import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
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
          color: const Color(0xFF485266),
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
            widget.text, // Fix: Correct reference to the text property
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
