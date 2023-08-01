import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkingService {
  NetworkingService({required this.context, required this.url});

  BuildContext context;
  final String url;

  // Get weather data for the locations Durchausen, Gunningen and Weigheim
  Future getWeatherData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      showSnackBar('Error${response.statusCode}');
    }
  }

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
