import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/MapService.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:gan/pages/MyMap.dart';
import 'package:google_fonts/google_fonts.dart';

class LabeledInputBox extends StatefulWidget {
  final bool isInputLocation;
  final String label;
  final String placeholder;
  final double width;
  final double height;
  final bool isObscure;
  final TextEditingController textController;
  final bool showCatIcon;
  final bool showPencilIcon;
  final int maxLines;

  const LabeledInputBox({
    super.key,
    required this.isInputLocation,
    this.label = "",
    this.placeholder = "No placeholder...",
    required this.width,
    this.height = 70,
    required this.textController,
    this.isObscure = false, // Flag to toggle password visibility
    this.showCatIcon = true,
    this.showPencilIcon = false,
    this.maxLines = 1,
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
                        ? Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              TextField(
                                enabled: false,
                                controller: widget.textController,
                                maxLines: widget.maxLines,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.pin_drop,
                                    size: 20,
                                    color: Colors.red,
                                  ),
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
                              Positioned.fill(
                                child: GestureDetector(
                                  onTap: () async {
                                    GeoPoint coordinates = AuthService
                                        .userData?['locationCoordinates'];

                                    final LatLng? selectedLocation =
                                        await Navigator.push<LatLng>(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => MyMap(
                                              isPickingLocation: true,
                                              initialCoordinates:
                                                  LatLng(coordinates.latitude, coordinates.longitude),
                                            ),
                                          ),
                                        );

                                    // If a location was picked, convert it to a readable address
                                    if (selectedLocation != null) {
                                      widget.textController.text =
                                          await MapService.getAddressFromCoordinates(
                                            GeoPoint(selectedLocation.latitude, selectedLocation.longitude),
                                          );
                                    } else {
                                      Fluttertoast.showToast(
                                        msg:
                                            "No address found for selected location.",
                                      );
                                    }
                                  },
                                  behavior: HitTestBehavior.translucent,
                                ),
                              ),
                            ],
                          )
                        : TextField(
                            controller: widget.textController,
                            maxLines: widget.maxLines,
                            decoration: InputDecoration(
                              suffixIcon: widget.showPencilIcon
                                  ? Image.asset(
                                      'assets/images/pencil.png',
                                      width: 24,
                                    )
                                  : null,
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
          widget.showCatIcon
              ? Positioned(
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
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
