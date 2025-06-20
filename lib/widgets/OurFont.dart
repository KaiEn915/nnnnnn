import 'package:flutter/material.dart';

class OurFont extends StatelessWidget {
  const OurFont({super.key, required this.text, this.letterSpacing = 3.30, this.fontSize=22, this.filledColor=false});

  final String text;
  final double fontSize;
  final double letterSpacing;
  final bool filledColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        filledColor? SizedBox(): Align(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: "IBM Plex Sans",
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              letterSpacing: letterSpacing,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..color = const Color(0xC0305B7E),
            ),
          ),
        ),
        Align(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              letterSpacing: letterSpacing,
              fontWeight: FontWeight.bold,
              fontFamily: "IBM Plex Sans",
              decoration: TextDecoration.none,
              fontSize: fontSize,
              color: filledColor? const Color(0xC0305B7E):Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(0, 8),
                  blurRadius: 16,
                  color: Colors.black.withAlpha(64),
                ),
              ],
            ),
          ),
        ),
        // Fill
      ],
    );
  }
}
