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
        seconds: kTimerAnimation,
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Lottie.network(
                  getLottieFile(1),
                  width: kWidth,
                  height: kHeight,
                ),
                Lottie.network(
                  getLottieFile(3),
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
  String getLottieFile(int number) {
    List<String> lottieFiles = [
      'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Animationen%2Ffootball-easter-egg.json?alt=media&token=5141b8a4-4135-4b6e-bb8e-ec47ff2a102f',
      'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Animationen%2Ffootballer.json?alt=media&token=02bac5a9-812e-4769-b02b-da4434f07cbc',
      'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Animationen%2Ffootball-team-players.json?alt=media&token=d8795dbd-f1f5-46c1-87fc-f567ac52b444',
      'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Animationen%2Floading_text.json?alt=media&token=e3fb8fa5-2c45-4f4c-99b6-12857843c933',
      'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Animationen%2Fsoccer-empty-state.json?alt=media&token=9898562a-0e5c-4f12-8da4-ac002393272e',
      'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Animationen%2Fsoccer-player.json?alt=media&token=01bdc6a4-d633-479d-a072-fe00a8fb1a7a',
      'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Animationen%2Fsoccer-player-kick-on-the-ball.json?alt=media&token=00065f90-70ea-4294-9931-2895a468e3ca',
    ];

    return lottieFiles[number];
  }
}
