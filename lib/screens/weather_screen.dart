import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/services/location_service.dart';
import '../constants/padding.dart';
import '../widgets/navigation_drawer.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  static const String id = 'weather_screen';

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Wetter'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void getLocation() async {
    LocationService location = LocationService();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
    print(location.altitude);
  }

// Loading builder
/*Widget loadingBuilder(BuildContext context, Widget child,
      ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      isLoading = false;
      return child;
    }
    return const CircularProgressIndicator(
      color: kSGMColorGreen,
    );
  }*/

  // Show snack bar
  void showSnackBar(String snackBarText) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          snackBarText,
        ),
      ),
    );
  }
}
