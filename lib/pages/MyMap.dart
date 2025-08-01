
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyMap extends StatefulWidget {
  const MyMap({
    super.key,
    required this.isPickingLocation,
    required this.initialCoordinates,
    this.mapController,
  });

  final bool isPickingLocation;
  final LatLng initialCoordinates;
  final MapController? mapController;

  @override
  State<StatefulWidget> createState() =>_MyMapState();

}

class _MyMapState extends State<MyMap> {
  late final LatLng _center;
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    _center = widget.initialCoordinates;
    if (widget.isPickingLocation) {
      selectedLocation = _center;
    }
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
              onTap: widget.isPickingLocation
                  ? (tapPosition, point) {
                      setState(() {
                        selectedLocation = point;
                      });
                    }
                  : null,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.myfluttermap',
              ),
              if (widget.isPickingLocation && selectedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: selectedLocation!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                )
              else
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
                  if (widget.isPickingLocation) {
                    Navigator.of(context).pop(null); // cancel picking
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ),
          if (widget.isPickingLocation)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Center(
                  child: ElevatedButton(
                    onPressed: selectedLocation == null
                        ? null
                        : () => Navigator.of(context).pop(GeoPoint(selectedLocation!.latitude, selectedLocation!.longitude)),
                    child: const Text('Confirm Location'),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
