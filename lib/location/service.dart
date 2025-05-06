import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> getCurrentLocation() async {
    // Check if location services are enabled
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check permission status
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    // Get current position
    return await Geolocator.getCurrentPosition();
  }

  static Future<String> getCityName({
    required double latitude,
    required double longitude,
  }) async {
    final places = await placemarkFromCoordinates(latitude, longitude);

    if (places.isNotEmpty) {
      final Placemark place = places.first;
      return place.locality ?? 'Unknown city';
    } else {
      return 'City not found';
    }
  }
}
