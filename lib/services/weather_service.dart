import 'package:flutter/material.dart';
import '../constants/api_key.dart';
import 'location_service.dart';
import 'networking_service.dart';

class WeatherService {
  // Get weather for Durchhausen, Gunningen and Weigheim
  Future<dynamic> getLocationWeather(BuildContext context) async {
    LocationService location = LocationService();
    await location.getCurrentLocation();

    NetworkingService networkingServiceDu = NetworkingService(
      context: context,
      url: 'https://api.openweathermap.org/data/2.5/weather?'
          'lat=${location.latitudeDu}&'
          'lon=${location.longitudeDu}&'
          'appid=$kApiKey&'
          'units=metric&'
          'lang=de',
    );

    NetworkingService networkingServiceGu = NetworkingService(
      context: context,
      url: 'https://api.openweathermap.org/data/2.5/weather?'
          'lat=${location.latitudeGu}&'
          'lon=${location.longitudeGu}&'
          'appid=$kApiKey&'
          'units=metric&'
          'lang=de',
    );

    NetworkingService networkingServiceWe = NetworkingService(
      context: context,
      url: 'https://api.openweathermap.org/data/2.5/weather?'
          'lat=${location.latitudeWe}&'
          'lon=${location.longitudeWe}&'
          'appid=$kApiKey&'
          'units=metric&'
          'lang=de',
    );

    var weatherDataDu = await networkingServiceDu.getWeatherData();
    var weatherDataGu = await networkingServiceGu.getWeatherData();
    var weatherDataWe = await networkingServiceWe.getWeatherData();

    var weatherData = [
      weatherDataDu,
      weatherDataGu,
      weatherDataWe,
    ];

    return weatherData;
  }

  // Get weather icon for Durchhausen, Gunningen and Weigheim
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
}
