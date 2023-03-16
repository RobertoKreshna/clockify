import 'package:geolocator/geolocator.dart';

class GeoLocator {
  static double calculateDistance(double currentLat, double currentLong,
      double elementLat, double elementLong) {
    return Geolocator.distanceBetween(
        currentLat, currentLong, elementLat, elementLong);
  }
}
