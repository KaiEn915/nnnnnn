import 'dart:io';
import 'package:latlong2/latlong.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gan/pages/MyMap.dart';
import 'package:google_fonts/google_fonts.dart';

class LabeledInputBox extends StatefulWidget {
  final bool isInputLocation;
  final String label;
  final String placeholder;
  final double width;
  final double height;
  final bool isObscure;
  final TextEditingController? textController;

  const LabeledInputBox({
    super.key,
    required this.isInputLocation,
    this.label = "No label",
    this.placeholder = "No placeholder...",
    required this.width,
    this.height = 70,
    this.textController,
    this.isObscure = false, // Flag to toggle password visibility
  });
  @override
  State<LabeledInputBox> createState() => _LabeledInputBox();
}

class _LabeledInputBox extends State<LabeledInputBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 4), // spacing between label and input
              // Input box
              Expanded(
                child: Container(
                  width: widget.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFFE0E0E0),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: widget.isInputLocation
                        ? GestureDetector(
                            onTap: () async {
                              LatLng? location = await MyMap.pickLocationFromMap(
                                context,
                              );

                              print("location: $location");
                              widget.textController?.text=location.toString();
                              print(widget.textController?.text);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 25,
                              children: [
                                Text(widget.placeholder),
                                Icon(Icons.pin_drop, color: Colors.red),
                              ],
                            ),
                          )
                        : TextField(
                            controller: widget.textController,
                            decoration: InputDecoration(
                              hintText: widget.placeholder,
                              border: InputBorder.none,
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
            ],
          ),
          Positioned(
            right: 0,
            top: -10,
            child: Container(
              width: 64.69,
              height: 60,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/cat.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
