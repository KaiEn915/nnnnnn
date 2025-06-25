import 'package:flutter/Material.dart';

class OurUI{
  static ShapeDecoration shapeDecoration({Color color= const Color(0xC0FFFFFF)}) {
    return ShapeDecoration(
      color: color,
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


}

