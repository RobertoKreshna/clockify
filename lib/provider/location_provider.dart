import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocator extends ChangeNotifier {
  bool servicestatus = false;
  late LocationPermission permission;
  late Position position;
  var lat = "", long = "";

  void getLocation() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        long = "permissions are";
        lat = "denied";
      } else if (permission == LocationPermission.deniedForever) {
        long = "permissions are";
        lat = "permanently denied";
      } else {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        lat = position.latitude.toString();
        long = position.longitude.toString();
      }
    } else {
      long = "no gps";
      lat = "service";
    }
    notifyListeners();
  }

  static double calculateDistance(double currentLat, double currentLong,
      double elementLat, double elementLong) {
    return Geolocator.distanceBetween(
        currentLat, currentLong, elementLat, elementLong);
  }
}
