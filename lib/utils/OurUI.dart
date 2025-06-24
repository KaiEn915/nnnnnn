import 'package:flutter/Material.dart';

class OurUI{
  static ShapeDecoration shapeDecoration() {
    return ShapeDecoration(
      color: Colors.white.withAlpha(192),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadows: [
        BoxShadow(
          color: Color(0x3F000000),
          blurRadius: 4,
          offset: Offset(0, 4),
          spreadRadius: 0,
        ),
      ],
    );
  }
  static Widget font({
    required String text,
    double fontSize = 22,
    double letterSpacing = 3.3,
    bool filledColor = false,
  }) {
    return Stack(
      children: [
        if (!filledColor)
          Align(
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
              decoration: TextDecoration.none,
              fontFamily: "IBM Plex Sans",
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              letterSpacing: letterSpacing,
              color: filledColor ? const Color(0xC0305B7E) : Colors.white,
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
      ],
    );
  }

}

