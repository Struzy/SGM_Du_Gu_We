import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/screens/email_verification_screen.dart';
import 'package:sgm_du_gu_we/screens/first_squad_league_screen.dart';
import 'package:sgm_du_gu_we/screens/home_screen.dart';
import 'package:sgm_du_gu_we/screens/imprint_screen.dart';
import 'package:sgm_du_gu_we/screens/login_screen.dart';
import 'package:sgm_du_gu_we/screens/main_screen.dart';
import 'package:sgm_du_gu_we/screens/registration_screen.dart';
import 'package:sgm_du_gu_we/screens/second_squad_league_screen.dart';
import 'package:sgm_du_gu_we/screens/splash_screen.dart';
import 'constants/color.dart';
import 'constants/elevated_button.dart';
import 'constants/font_family.dart';
import 'constants/font_size.dart';
import 'constants/text_field.dart';

/*void main() => runApp(
      SGMDuGuWe(),
    );*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    SGMDuGuWe(),
  );
}

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
              kElevatedButtonHeight,
              kElevatedButtonWidth,
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
          contentPadding: EdgeInsets.symmetric(
            vertical: kVertical,
            horizontal: kHorizontal,
          ),
          filled: true,
          iconColor: Colors.black,
          fillColor: Colors.white,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(kBorderRadius),
            ),
          ),
        ),
      ),
      initialRoute: HomeScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        MainScreen.id: (context) => const MainScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        EmailVerificationScreen.id: (context) =>
            const EmailVerificationScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        ImprintScreen.id: (context) => const ImprintScreen(),
        FirstSquadLeagueScreen.id: (context) => const FirstSquadLeagueScreen(),
        SecondSquadLeagueScreen.id: (context) =>
            const SecondSquadLeagueScreen(),
      },
    );
  }
}
