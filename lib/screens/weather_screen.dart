import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sgm_du_gu_we/screens/weather_detail_screen.dart';
import 'package:sgm_du_gu_we/services/weather_service.dart';
import '../constants/padding.dart';
import '../constants/spin_kit_double_bounce.dart';

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
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(
            kPadding,
          ),
          child: Center(
            child: SpinKitDoubleBounce(
              color: Colors.white,
              size: kSizeSpinKitDoubleBounce,
            ),
          ),
        ),
      ),
    );
  }

  // Get location data of Durchhausen, Gunningen and Weigheim
  void getLocationData() async {
    var weatherData = await WeatherService().getLocationWeather(context);

    navigateToWeatherDetailScreen(
      weatherData,
    );
  }

  // Navigate to weather detail screen
  void navigateToWeatherDetailScreen(dynamic weatherData) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherDetailScreen(
        locationWeather: weatherData,
      );
    }));
  }

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
