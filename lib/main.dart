import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgm_du_gu_we/screens/baar_cup_screen.dart';
import 'package:sgm_du_gu_we/screens/chat_screen.dart';
import 'package:sgm_du_gu_we/screens/email_verification_screen.dart';
import 'package:sgm_du_gu_we/screens/first_squad_league_screen.dart';
import 'package:sgm_du_gu_we/screens/first_squad_screen.dart';
import 'package:sgm_du_gu_we/screens/football_club_screen.dart';
import 'package:sgm_du_gu_we/screens/gallery_screen.dart';
import 'package:sgm_du_gu_we/screens/home_screen.dart';
import 'package:sgm_du_gu_we/screens/imprint_screen.dart';
import 'package:sgm_du_gu_we/screens/login_screen.dart';
import 'package:sgm_du_gu_we/screens/lyrics_screen.dart';
import 'package:sgm_du_gu_we/screens/main_screen.dart';
import 'package:sgm_du_gu_we/screens/media_player_screen.dart';
import 'package:sgm_du_gu_we/screens/miscellaneous_screen.dart';
import 'package:sgm_du_gu_we/screens/penalty_catalog_screen.dart';
import 'package:sgm_du_gu_we/screens/penalty_screen.dart';
import 'package:sgm_du_gu_we/screens/player_statistics_screen.dart';
import 'package:sgm_du_gu_we/screens/preparation_plan_screen.dart';
import 'package:sgm_du_gu_we/screens/registration_screen.dart';
import 'package:sgm_du_gu_we/screens/second_squad_league_screen.dart';
import 'package:sgm_du_gu_we/screens/second_squad_screen.dart';
import 'package:sgm_du_gu_we/screens/splash_screen.dart';
import 'package:sgm_du_gu_we/screens/sprinkle_plan_screen.dart';
import 'package:sgm_du_gu_we/screens/squad_screen.dart';
import 'package:sgm_du_gu_we/screens/weather_screen.dart';
import 'constants/color.dart';
import 'constants/elevated_button.dart';
import 'constants/font_family.dart';
import 'constants/font_size.dart';
import 'constants/text_field.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const SGMDuGuWe());
  });
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
      initialRoute: MiscellaneousScreen.id,
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
        FootballClubScreen.id: (context) => const FootballClubScreen(),
        FirstSquadScreen.id: (context) => const FirstSquadScreen(),
        SecondSquadScreen.id: (context) => const SecondSquadScreen(),
        PenaltyCatalogScreen.id: (context) => const PenaltyCatalogScreen(),
        SprinklePlanScreen.id: (context) => const SprinklePlanScreen(),
        PreparationPlanScreen.id: (context) => const PreparationPlanScreen(),
        LyricsScreen.id: (context) => const LyricsScreen(),
        MiscellaneousScreen.id: (context) => const MiscellaneousScreen(),
        BaarCupScreen.id: (context) => const BaarCupScreen(),
        PlayerStatisticsScreen.id: (context) => const PlayerStatisticsScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
        PenaltyScreen.id: (context) => const PenaltyScreen(),
        SquadScreen.id: (context) => const SquadScreen(),
        GalleryScreen.id: (context) => const GalleryScreen(),
        MediaPlayerScreen.id: (context) => const MediaPlayerScreen(),
        WeatherScreen.id: (context) => const WeatherScreen(),
      },
    );
  }
}
