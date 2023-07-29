import 'package:geolocator/geolocator.dart';

class LocationService {
  late double latitude;
  late double longitude;
  late double altitude;

  // Get locations of Durchhausen, Gunningen and Weigheim
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      latitude = position.latitude;
      longitude = position.longitude;
      altitude = position.altitude;
    } catch (e) {
      print(e.toString());
    }
  }
}