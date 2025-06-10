import 'package:flutter/material.dart';

class LabeledInputBox extends StatelessWidget {
  final String label;
  final String placeholder;
  final double width;
  final bool hasBackground;
  final bool isPassword;
  final TextEditingController controller;

  const LabeledInputBox({
    super.key,
    required this.label,
    required this.placeholder,
    required this.width,
    required this.hasBackground,
    required this.controller,
    this.isPassword = false, // Flag to toggle password visibility
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height: 75,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 13,
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 35,
                child: Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 16,
                    children: [
                      SizedBox(
                        child: Text(
                          placeholder,
                          style: TextStyle(
                            color: const Color(0xFF828282),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 262,
                top: -3,
                child: Container(
                  width: 64.69,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/cat.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
