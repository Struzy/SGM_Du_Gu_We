import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/screens/login_screen.dart';

import 'package:sgm_du_gu_we/screens/main_screen.dart';
import 'package:sgm_du_gu_we/screens/registration_screen.dart';
import 'package:sgm_du_gu_we/screens/splash_screen.dart';
import 'constants/color.dart';
import 'constants/elevated_button.dart';
import 'constants/font_family.dart';
import 'constants/font_size.dart';

void main() => runApp(
      const SGMDuGuWe(),
    );

class SGMDuGuWe extends StatelessWidget {
  const SGMDuGuWe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: kSourceSansPro,
        scaffoldBackgroundColor: kSGMColorGreenLight,
        appBarTheme: const AppBarTheme(
          elevation: kElevation,
          backgroundColor: kSGMColorGreen,
          foregroundColor: Colors.black,
          centerTitle: true,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: kFontsizeAppBar,
          ),
          bodyMedium: TextStyle(
            fontSize: kFontsizeBody,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: kElevation,
            fixedSize: const Size(
              kElevationButtonHeight,
              kElevationButtonWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                kBorderRadius,
              ),
            ),
            backgroundColor: kSGMColorGreen,
            foregroundColor: Colors.black,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(kBorderRadius),
            ),
          ),
        ),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        MainScreen.id: (context) => const MainScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
      },
    );
  }
}
