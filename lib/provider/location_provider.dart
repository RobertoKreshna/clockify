import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocator extends ChangeNotifier {
  static double calculateDistance(double currentLat, double currentLong,
      double elementLat, double elementLong) {
    return Geolocator.distanceBetween(
        currentLat, currentLong, elementLat, elementLong);
  }
}
