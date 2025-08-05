import 'package:flutter/material.dart';

class OurFont extends StatelessWidget {
  final String text;
  final double fontSize;
  final double letterSpacing;
  final bool filledColor;

  const OurFont({
    super.key,
    required this.text,
    this.fontSize = 22,
    this.letterSpacing = 3.3,
    this.filledColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!filledColor)
          Text(
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
            softWrap: true,
            overflow: TextOverflow.visible,
            maxLines: null,
          ),
        Text(
          text,
          textAlign: TextAlign.center,
          softWrap: true,
          overflow: TextOverflow.visible,
          maxLines: null,
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
      ],
    );
  }

}
