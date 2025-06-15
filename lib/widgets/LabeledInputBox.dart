import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabeledInputBox extends StatefulWidget {
  final String label;
  final String placeholder;
  final double width;
  final bool hasBackground;
  final bool isObscure;
  final TextEditingController controller;

  const LabeledInputBox({
    super.key,
    required this.label,
    required this.placeholder,
    required this.width,
    required this.hasBackground,
    required this.controller,
    this.isObscure = false, // Flag to toggle password visibility
  });

  @override
  State<LabeledInputBox> createState() => _LabeledInputBox();
}

class _LabeledInputBox extends State<LabeledInputBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.width,
          height: 85,
          child: Stack(
            children: [
              Positioned(
                child: Text(
                  widget.label,
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
                top: 20,
                child: Container(
                  width: widget.width,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFE0E0E0),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Container(
                    child: TextField(
                      controller: widget.controller,
                      decoration: InputDecoration(
                        hintText: widget.placeholder,
                        border: InputBorder.none
                      ),
                      style: GoogleFonts.ibmPlexSans(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      obscureText: widget.isObscure,
                    ),
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
