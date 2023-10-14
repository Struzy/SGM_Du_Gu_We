import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgm_du_gu_we/screens/baar_cup_screen.dart';
import 'package:sgm_du_gu_we/screens/chat_screen.dart';
import 'package:sgm_du_gu_we/screens/email_verification_screen.dart';
import 'package:sgm_du_gu_we/screens/finance_screen.dart';
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
import 'package:sgm_du_gu_we/screens/settings_screen.dart';
import 'package:sgm_du_gu_we/screens/splash_screen.dart';
import 'package:sgm_du_gu_we/screens/sprinkle_plan_screen.dart';
import 'package:sgm_du_gu_we/screens/squad_screen.dart';
import 'package:sgm_du_gu_we/screens/training_participation_screen.dart';
import 'package:sgm_du_gu_we/screens/vacation_screen.dart';
import 'package:sgm_du_gu_we/screens/video_player_screen.dart';
import 'package:sgm_du_gu_we/screens/weather_screen.dart';
import 'package:sgm_du_gu_we/services/messaging_service.dart';
import 'constants/color.dart';
import 'constants/elevated_button.dart';
import 'constants/font_family.dart';
import 'constants/font_size.dart';
import 'constants/text_field.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDnOKl18AsK_K3tP7Oogul-aYS1fC0xrt8',
      appId: '1:785053102637:android:f89d7a1c61f303b1727ea4',
      messagingSenderId: '785053102637',
      projectId: 'sgm-duguwe',
    ),
  );
  await MessagingService().initNotifications();
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      const SGMDuGuWe(),
    );
  });
}

class SGMDuGuWe extends StatelessWidget {
  const SGMDuGuWe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      // Set to false if application is completed
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
      initialRoute: SplashScreen.id,
      routes: {
        // Splash screen
        SplashScreen.id: (context) => const SplashScreen(),

        // Hauptseite
        MainScreen.id: (context) => const MainScreen(),

        // Registrierung
        RegistrationScreen.id: (context) => const RegistrationScreen(),

        // Anmeldung
        LoginScreen.id: (context) => const LoginScreen(),

        // E-Mail Verifikation
        EmailVerificationScreen.id: (context) =>
            const EmailVerificationScreen(),

        // Hauptmenü
        HomeScreen.id: (context) => const HomeScreen(),

        // Fußballverein
        FootballClubScreen.id: (context) => const FootballClubScreen(),

        // Kader
        SquadScreen.id: (context) => const SquadScreen(),

        // Spielerstatistik
        PlayerStatisticsScreen.id: (context) => const PlayerStatisticsScreen(),

        // 1. Mannschaft
        FirstSquadScreen.id: (context) => const FirstSquadScreen(),

        // 2. Mannschaft
        SecondSquadScreen.id: (context) => const SecondSquadScreen(),

        // Kreisliga B2 Württemberg
        FirstSquadLeagueScreen.id: (context) => const FirstSquadLeagueScreen(),

        // Kreisliga C3 Württemberg
        SecondSquadLeagueScreen.id: (context) =>
            const SecondSquadLeagueScreen(),

        // Baarpokal
        BaarCupScreen.id: (context) => const BaarCupScreen(),

        // Trainingsbeteiligung
        TrainingParticipationScreen.id: (context) =>
            const TrainingParticipationScreen(),

        // Strafenkatalog
        PenaltyCatalogScreen.id: (context) => const PenaltyCatalogScreen(),

        // Strafen
        PenaltyScreen.id: (context) => const PenaltyScreen(),

        // Urlaub
        VacationScreen.id: (context) => const VacationScreen(),

        // Vorbereitungsplan
        PreparationPlanScreen.id: (context) => const PreparationPlanScreen(),

        // Abstreuplan
        SprinklePlanScreen.id: (context) => const SprinklePlanScreen(),

        // Mediathek
        MediaPlayerScreen.id: (context) => const MediaPlayerScreen(),

        // Liedtexte
        LyricsScreen.id: (context) => const LyricsScreen(),

        // Videothek
        VideoPlayerScreen.id: (context) => const VideoPlayerScreen(),

        // Galerie
        GalleryScreen.id: (context) => const GalleryScreen(),

        // Finanzen
        FinanceScreen.id: (context) => const FinanceScreen(),

        // Chat
        ChatScreen.id: (context) => const ChatScreen(),

        // Wetter Sportplätze
        WeatherScreen.id: (context) => const WeatherScreen(),

        // Bedienung Abstreuwagen
        OperationSpreaderTruckScreen.id: (context) =>
            const OperationSpreaderTruckScreen(),

        // Impressum
        ImprintScreen.id: (context) => const ImprintScreen(),

        // Einstellungen
        SettingsScreen.id: (context) => const SettingsScreen(),
      },
    );
  }
}
