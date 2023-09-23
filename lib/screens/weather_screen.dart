import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sgm_du_gu_we/services/weather_service.dart';
import '../constants/box_size.dart';
import '../constants/color.dart';
import '../constants/font_family.dart';
import '../constants/font_size.dart';
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
    return const Scaffold(
      body: SafeArea(
        child: Padding(
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

class WeatherDetailScreen extends StatefulWidget {
  const WeatherDetailScreen({super.key, this.locationWeather});

  final locationWeather;

  static const String id = 'weather_screen';

  @override
  WeatherDetailScreenState createState() => WeatherDetailScreenState();
}

class WeatherDetailScreenState extends State<WeatherDetailScreen> {
  WeatherService weatherServiceDu = WeatherService();
  WeatherService weatherServiceGu = WeatherService();
  WeatherService weatherServiceWe = WeatherService();

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
    updateUI(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wetter Sportplätze',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: kSGMColorGreen,
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Durchhausen',
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: kBoxHeight,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: kSGMColorGreen,
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: kBoxHeight,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: kSGMColorGreen,
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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
              ],
            ),
          ),
        ),
      ),
    );
  }

// Update user interface
  void updateUI(dynamic weatherData) async {
    setState(() {
      if (weatherData[0] == null) {
        temperatureDu = 0;
        weatherIconDu = '';
        descriptionDu = 'Keine Wetterdaten verfügbar.';
        cityNameDu = '';
        return;
      }
      double temp = weatherData[0]['main']['temp'];
      temperatureDu = temp.toInt();
      conditionDu = weatherData[0]['weather'][0]['id'];
      weatherIconDu = weatherServiceDu.getWeatherIcon(conditionDu);
      descriptionDu = weatherData[0]['weather'][0]['description'];
      cityNameDu = weatherData[0]['name'];
    });

    setState(() {
      if (weatherData[1] == null) {
        temperatureGu = 0;
        weatherIconGu = '';
        descriptionGu = 'Keine Wetterdaten verfügbar.';
        cityNameGu = '';
        return;
      }
      double temp = weatherData[1]['main']['temp'];
      temperatureGu = temp.toInt();
      conditionGu = weatherData[1]['weather'][0]['id'];
      weatherIconGu = weatherServiceGu.getWeatherIcon(conditionGu);
      descriptionGu = weatherData[1]['weather'][0]['description'];
      cityNameGu = weatherData[1]['name'];
    });

    setState(() {
      if (weatherData[2] == null) {
        temperatureWe = 0;
        weatherIconWe = '';
        descriptionWe = 'Keine Wetterdaten verfügbar.';
        cityNameWe = '';
        return;
      }
      double temp = weatherData[2]['main']['temp'];
      temperatureWe = temp.toInt();
      conditionWe = weatherData[2]['weather'][0]['id'];
      weatherIconWe = weatherServiceWe.getWeatherIcon(conditionWe);
      descriptionWe = weatherData[2]['weather'][0]['description'];
      cityNameWe = weatherData[2]['name'];
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
