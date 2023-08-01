import 'package:sgm_du_gu_we/constants/location.dart';

class LocationService {
  late String latitudeDu;
  late String longitudeDu;
  late String latitudeGu;
  late String longitudeGu;
  late String latitudeWe;
  late String longitudeWe;

  // Get location data for the locations Durchausen, Gunningen and Weigheim
  Future<void> getCurrentLocation() async {

    // Geographic location data of Durchhausen
    latitudeDu = kLatitudeDu;
    longitudeDu = kLongitudeDu;

    // Geographic location data of Gunningen
    latitudeGu = kLatitudeGu;
    longitudeGu = kLongitudeGu;

    // Geographic location data of Weigheim
    latitudeWe = kLatitudeWe;
    longitudeWe = kLongitudeWe;
  }
}