import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MyMap extends StatefulWidget {
  const MyMap({
    super.key,
    required this.isPromptingLocation,
    required this.initialPosition,
    this.mapController,
  });

  final bool isPromptingLocation;
  final Position initialPosition;
  final MapController? mapController;

  static Future<LatLng?> pickLocationFromMap(BuildContext context) async {
    LatLng? selectedLocation;

    return await showDialog<LatLng>(
      context: context,
      builder: (context) {
        return Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(3.1390, 101.6869), // Example location
                      initialZoom: 13.0,
                      onTap: (tapPosition, point) {
                        setState(() {
                          selectedLocation = point;
                        });
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      if (selectedLocation != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: selectedLocation!,
                              width: 40,
                              height: 40,
                              child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                            ),
                          ],
                        ),
                    ],
                  ),
                  Container(
                    width: 300,
                    height: 60,
                    child: SafeArea(
                      child: Center(
                        child: ElevatedButton(

                          onPressed: selectedLocation == null
                              ? null
                              : ()=> {
                            Navigator.of(context).pop(selectedLocation),
                          },
                          child: Text('Confirm Location'),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late final LatLng _center;
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    _center = LatLng(
      widget.initialPosition.latitude,
      widget.initialPosition.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 15.0,
              onTap: (tapPos, point) {
                setState(() {
                  selectedLocation = point;
                });
              },
            ),

            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _center,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution('OpenStreetMap contributors'),
                ],
              ),
            ],
          ),
          Positioned(
            top: 40,
            left: 10,
            child: SafeArea(
              child: CupertinoButton(
                color: Colors.white.withAlpha(204),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text('Back'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          !widget.isPromptingLocation
              ? Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SafeArea(
                      child: CupertinoButton(
                        color: Colors.white.withAlpha(204),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Text('Confirm Location'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
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
