import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/api_key.dart';
import 'package:sgm_du_gu_we/constants/font_size.dart';
import 'package:sgm_du_gu_we/constants/location.dart';
import 'package:sgm_du_gu_we/services/weather_service.dart';
import '../constants/box_size.dart';
import '../constants/font_family.dart';
import '../constants/padding.dart';
import '../constants/divider_thickness.dart';
import '../widgets/navigation_drawer.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  static const String id = 'weather_screen';

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {

  // Durchhausen
  String cityNameDu = 'Durchhausen';
  String weatherIconDu = '';
  int temperatureDu = 0;
  String descriptionDu = '';
  int conditionDu = 0;

  // Gunningen
  String cityNameGu = 'Gunningen';
  String weatherIconGu = '';
  int temperatureGu = 0;
  String descriptionGu = '';
  int conditionGu = 0;

  // Weigheim
  String cityNameWe = 'Weigheim';
  String weatherIconWe = '';
  int temperatureWe = 0;
  String descriptionWe = '';
  int conditionWe = 0;

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Text(
            'Wetter',
          ),
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
                  const Text(
                    'Duchhausen',
                    style: TextStyle(
                      fontFamily: kSpartanMB,
                      fontSize: kFontsizeTitle,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        weatherIconDu,
                        style: const TextStyle(
                          fontFamily: kSpartanMB,
                          fontSize: kFontsizeTitle,
                        ),
                      ),
                      const SizedBox(
                        width: kBoxWidth,
                      ),
                      Text(
                        '$temperatureDu°C',
                        style: const TextStyle(
                          fontFamily: kSpartanMB,
                          fontSize: kFontsizeTitle,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    descriptionDu,
                    style: const TextStyle(
                      fontFamily: kSpartanMB,
                      fontSize: kFontsizeTitle,
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  const Divider(
                    thickness: kDividerThickness,
                    color: Colors.black54,
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  const Text(
                    'Gunningen',
                    style: TextStyle(
                      fontFamily: kSpartanMB,
                      fontSize: kFontsizeTitle,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        weatherIconGu,
                        style: const TextStyle(
                          fontFamily: kSpartanMB,
                          fontSize: kFontsizeTitle,
                        ),
                      ),
                      const SizedBox(
                        width: kBoxWidth,
                      ),
                      Text(
                        '$temperatureGu°C',
                        style: const TextStyle(
                          fontFamily: kSpartanMB,
                          fontSize: kFontsizeTitle,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    descriptionGu,
                    style: const TextStyle(
                      fontFamily: kSpartanMB,
                      fontSize: kFontsizeTitle,
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  const Divider(
                    thickness: kDividerThickness,
                    color: Colors.black54,
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  const Text(
                    'Weigheim',
                    style: TextStyle(
                      fontFamily: kSpartanMB,
                      fontSize: kFontsizeTitle,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        weatherIconWe,
                        style: const TextStyle(
                          fontFamily: kSpartanMB,
                          fontSize: kFontsizeTitle,
                        ),
                      ),
                      const SizedBox(
                        width: kBoxWidth,
                      ),
                      Text(
                        '$temperatureWe°C',
                        style: const TextStyle(
                          fontFamily: kSpartanMB,
                          fontSize: kFontsizeTitle,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    descriptionWe,
                    style: const TextStyle(
                      fontFamily: kSpartanMB,
                      fontSize: kFontsizeTitle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Update user interface
  void updateUI() async {
    WeatherService weatherServiceDu = WeatherService(
      url: 'https://api.openweathermap.org/data/2.5/weather?'
          'lat=$kLatitudeDu&'
          'lon=$kLongitudeDu&'
          'appid=$kApiKey&'
          'units=metric&'
          'lang=de',
    );

    WeatherService weatherServiceGu = WeatherService(
      url: 'https://api.openweathermap.org/data/2.5/weather?'
          'lat=$kLatitudeGu&'
          'lon=$kLongitudeGu&'
          'appid=$kApiKey&'
          'units=metric&'
          'lang=de',
    );

    WeatherService weatherServiceWe = WeatherService(
      url: 'https://api.openweathermap.org/data/2.5/weather?'
          'lat=$kLatitudeWe&'
          'lon=$kLongitudeWe&'
          'appid=$kApiKey&'
          'units=metric&'
          'lang=de',
    );

    var weatherDataDu = await weatherServiceDu.getWeatherData();
    var weatherDataGu = await weatherServiceGu.getWeatherData();
    var weatherDataWe = await weatherServiceWe.getWeatherData();

    setState(() {
      if (weatherDataDu == null) {
        temperatureDu = 0;
        weatherIconDu = '';
        descriptionDu = 'Keine Wetterdaten verfügbar.';
        cityNameDu = '';
        return;
      }
      double temp = weatherDataDu['main']['temp'];
      temperatureDu = temp.toInt();
      conditionDu = weatherDataDu['weather'][0]['id'];
      weatherIconDu = weatherServiceDu.getWeatherIcon(conditionDu);
      descriptionDu = weatherDataDu['weather'][0]['description'];
      cityNameDu = weatherDataDu['name'];
    });

    setState(() {
      if (weatherDataGu == null) {
        temperatureGu = 0;
        weatherIconGu = '';
        descriptionGu = 'Keine Wetterdaten verfügbar.';
        cityNameGu = '';
        return;
      }
      double temp = weatherDataGu['main']['temp'];
      temperatureGu = temp.toInt();
      conditionGu = weatherDataGu['weather'][0]['id'];
      weatherIconGu = weatherServiceGu.getWeatherIcon(conditionGu);
      descriptionGu = weatherDataGu['weather'][0]['description'];
      cityNameGu = weatherDataGu['name'];
    });

    setState(() {
      if (weatherDataWe == null) {
        temperatureWe = 0;
        weatherIconWe = '';
        descriptionWe = 'Keine Wetterdaten verfügbar.';
        cityNameWe = '';
        return;
      }
      double temp = weatherDataWe['main']['temp'];
      temperatureWe = temp.toInt();
      conditionWe = weatherDataWe['weather'][0]['id'];
      weatherIconWe = weatherServiceWe.getWeatherIcon(conditionWe);
      descriptionWe = weatherDataWe['weather'][0]['description'];
      cityNameWe = weatherDataWe['name'];
    });
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
