import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/font_size.dart';
import 'package:sgm_du_gu_we/screens/main_screen.dart';
import 'package:sgm_du_gu_we/screens/splash_screen.dart';
import 'constants/color.dart';
import 'constants/font_family.dart';

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
            backgroundColor: kSGMColorGreen,
            foregroundColor: Colors.black,
          ),
        ),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        MainScreen.id: (context) => const MainScreen(),
      },
    );
  }
}
