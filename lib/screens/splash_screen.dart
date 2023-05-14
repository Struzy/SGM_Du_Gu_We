import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/lottie_file.dart';
import '../constants/padding.dart';
import '../constants/timer.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String id = 'splash_screen';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(
      const Duration(
        seconds: kTimer,
      ),
      () => Navigator.pushNamed(
        context,
        MainScreen.id,
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Lottie.asset(
                  'animations/${getLottieFileName(1)}.json',
                  width: kWidth,
                  height: kHeight,
                ),
                Lottie.asset(
                  'animations/${getLottieFileName(3)}.json',
                  width: kWidth,
                  height: kHeight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Set a list of names for the lottie files which to choose the desired one
  // from
  String getLottieFileName(int number) {
    List<String> lottieFileNames = [
      'football-easter-egg',
      'footballer',
      'football-team-players',
      'loading_text',
      'soccer-empty-state',
      'soccer-player',
      'soccer-player-kick-on-the-ball',
    ];

    return lottieFileNames[number];
  }
}
