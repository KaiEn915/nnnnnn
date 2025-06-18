import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
class MapService{
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }


    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
  static Future<GeoPoint?> getCoordinatesFromAddress(String address) async {
    print("converting address $address to coordinates...");
    List<Location> locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      final location = locations.first;
      GeoPoint coordinates=GeoPoint(location.latitude, location.longitude);
      print("converted into latitude ${coordinates.latitude}, longitude ${coordinates.longitude}");
      return coordinates;
    }
    return null;
  }
  static Future<String> getAddressFromCoordinates(GeoPoint coor) async {
    print("searching for latitude ${coor.latitude}, longtitude ${coor.longitude}");
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        coor.latitude,
        coor.longitude,
      );
      print("placemarks found");

      if (placemarks.isNotEmpty) {
        print("is not empty");
        Placemark place = placemarks.first;
        print("place: $place");
        String address='${place.name}, ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
        print("address: $address");
        return address;
      } else {
        return "";
      }
    } catch (e) {
      print('Error getting location name: $e');
      return "";
    }
  }


}

