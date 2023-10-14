import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/box_size.dart';
import 'package:sgm_du_gu_we/constants/padding.dart';
import 'package:sgm_du_gu_we/screens/finance_screen.dart';
import 'package:sgm_du_gu_we/screens/home_screen.dart';
import 'package:sgm_du_gu_we/screens/settings_screen.dart';
import 'package:sgm_du_gu_we/screens/training_participation_screen.dart';
import 'package:sgm_du_gu_we/screens/weather_screen.dart';
import '../constants/circle_avatar.dart';
import '../constants/color.dart';
import '../constants/divider_thickness.dart';
import '../constants/font_family.dart';
import '../constants/font_size.dart';
import '../constants/sgm_logo_directory.dart';
import '../screens/baar_cup_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/first_squad_league_screen.dart';
import '../screens/first_squad_screen.dart';
import '../screens/football_club_screen.dart';
import '../screens/gallery_screen.dart';
import '../screens/imprint_screen.dart';
import '../screens/lyrics_screen.dart';
import '../screens/main_screen.dart';
import '../screens/media_player_screen.dart';
import '../screens/miscellaneous_screen.dart';
import '../screens/penalty_catalog_screen.dart';
import '../screens/penalty_screen.dart';
import '../screens/player_statistics_screen.dart';
import '../screens/preparation_plan_screen.dart';
import '../screens/second_squad_league_screen.dart';
import '../screens/second_squad_screen.dart';
import '../screens/sprinkle_plan_screen.dart';
import '../screens/squad_screen.dart';
import '../screens/vacation_screen.dart';
import '../screens/video_player_screen.dart';
import '../services/authentication_service.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => NavigationDrawerState();
}

class NavigationDrawerState extends State<NavigationDrawer> {
  late User? loggedInUser;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loggedInUser = AuthenticationService.getUser(context);
  }

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        color: kSGMColorGreen,
        padding: EdgeInsets.only(
          top: kPadding + MediaQuery.of(context).padding.top,
          bottom: kPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: kRadiusBurgerMenu,
              child: ClipOval(
                child: Image.network(
                  loggedInUser?.photoURL ?? kDefaultAvatarLogo,
                  fit: BoxFit.cover,
                  height: kRadius,
                  width: kRadius,
                  loadingBuilder: loadingBuilder,
                ),
              ),
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            Text(
              loggedInUser?.displayName ?? '',
              style: const TextStyle(
                fontSize: kFontsizeDisplayName,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              loggedInUser?.email ?? '',
              style: const TextStyle(
                fontSize: kFontsizeEmail,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );

  Widget menuItem(
          {required BuildContext context,
          required IconData icon,
          required String text,
          required String id}) =>
      ListTile(
        leading: Icon(
          icon,
        ),
        title: Text(
          text,
        ),
        onTap: () {
          Navigator.pop(
            context,
          );
          Navigator.pushNamed(
            context,
            id,
          );
        },
      );

  Widget buildMenuItems(BuildContext context) => Column(children: [
        // Hauptmenü
        menuItem(
          context: context,
          icon: Icons.home,
          text: 'Hauptmenü',
          id: HomeScreen.id,
        ),

        const Divider(
          color: Colors.black54,
          height: kDividerThickness,
        ),
        const Text(
          'Vereinsseite',
          style: TextStyle(
            fontFamily: kSourceSansPro,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Fußballverein
        menuItem(
          context: context,
          icon: Icons.sports_soccer,
          text: 'Fußballverein',
          id: FootballClubScreen.id,
        ),

        const Divider(
          color: Colors.black54,
          height: kDividerThickness,
        ),
        const Text(
          'Kader, Statistiken & Mannschaften',
          style: TextStyle(
            fontFamily: kSourceSansPro,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Kader
        menuItem(
          context: context,
          icon: Icons.group,
          text: 'Kader',
          id: SquadScreen.id,
        ),

        // Spielerstatistik
        menuItem(
          context: context,
          icon: Icons.assessment,
          text: 'Spielerstatistik',
          id: PlayerStatisticsScreen.id,
        ),

        // 1. Mannschaft
        menuItem(
          context: context,
          icon: Icons.group,
          text: '1. Mannschaft',
          id: FirstSquadScreen.id,
        ),

        // 2. Mannschaft
        menuItem(
          context: context,
          icon: Icons.group,
          text: '2. Mannschaft',
          id: SecondSquadScreen.id,
        ),

        const Divider(
          color: Colors.black54,
          height: kDividerThickness,
        ),
        const Text(
          'Wettbewerbe',
          style: TextStyle(
            fontFamily: kSourceSansPro,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Kreisliga B2 Württemberg
        menuItem(
          context: context,
          icon: Icons.sports_soccer,
          text: 'Kreisliga B2 Württemberg',
          id: FirstSquadLeagueScreen.id,
        ),

        // Kreisliga C3 Württemberg
        menuItem(
          context: context,
          icon: Icons.sports_soccer,
          text: 'Kreisliga C3 Württemberg',
          id: SecondSquadLeagueScreen.id,
        ),

        // Baarpokal
        menuItem(
          context: context,
          icon: Icons.emoji_events,
          text: 'Baarpokal',
          id: BaarCupScreen.id,
        ),

        const Divider(
          color: Colors.black54,
          height: kDividerThickness,
        ),
        const Text(
          'Kurz- u. langfristige Trainingsbeteiligungen',
          style: TextStyle(
            fontFamily: kSourceSansPro,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Trainingsbeteiligung
        menuItem(
          context: context,
          icon: Icons.event_available,
          text: 'Trainingsbeteiligung',
          id: TrainingParticipationScreen.id,
        ),

        const Divider(
          color: Colors.black54,
          height: kDividerThickness,
        ),
        const Text(
          'Strafenkatalog u. offene Strafen',
          style: TextStyle(
            fontFamily: kSourceSansPro,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Strafenkatalog
        menuItem(
          context: context,
          icon: Icons.assignment,
          text: 'Strafenkatalog',
          id: PenaltyCatalogScreen.id,
        ),

        // Strafen
        menuItem(
          context: context,
          icon: Icons.report_problem,
          text: 'Strafen',
          id: PenaltyScreen.id,
        ),

        const Divider(
          color: Colors.black54,
          height: kDividerThickness,
        ),
        const Text(
          'Abwesenheiten',
          style: TextStyle(
            fontFamily: kSourceSansPro,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Urlaub
        menuItem(
          context: context,
          icon: Icons.beach_access,
          text: 'Urlaub',
          id: VacationScreen.id,
        ),

        const Divider(
          color: Colors.black54,
          height: kDividerThickness,
        ),
        const Text(
          'Saisonpläne',
          style: TextStyle(
            fontFamily: kSourceSansPro,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Vorbereitungsplan
        menuItem(
          context: context,
          icon: Icons.assignment,
          text: 'Vorbereitungsplan',
          id: PreparationPlanScreen.id,
        ),

        // Abstreuplan
        menuItem(
          context: context,
          icon: Icons.assignment,
          text: 'Abstreuplan',
          id: SprinklePlanScreen.id,
        ),

        const Divider(
          color: Colors.black54,
          height: kDividerThickness,
        ),
        const Text(
          'Medien u. Liedtexte',
          style: TextStyle(
            fontFamily: kSourceSansPro,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Mediathek
        menuItem(
          context: context,
          icon: Icons.library_music,
          text: 'Mediathek',
          id: MediaPlayerScreen.id,
        ),

        // Liedtexte
        menuItem(
          context: context,
          icon: Icons.lyrics,
          text: 'Liedtexte',
          id: LyricsScreen.id,
        ),

        // Videothek
        menuItem(
          context: context,
          icon: Icons.video_collection,
          text: 'Videothek',
          id: VideoPlayerScreen.id,
        ),

        // Galerie
        menuItem(
          context: context,
          icon: Icons.photo_library,
          text: 'Galerie',
          id: GalleryScreen.id,
        ),

        const Divider(
          color: Colors.black54,
          height: kDividerThickness,
        ),
        const Text(
          'Kassen- u. Kontostände',
          style: TextStyle(
            fontFamily: kSourceSansPro,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Finanzen
        menuItem(
          context: context,
          icon: Icons.euro,
          text: 'Finanzen',
          id: FinanceScreen.id,
        ),

        const Divider(
          color: Colors.black54,
          height: kDividerThickness,
        ),
        const Text(
          'Austausch',
          style: TextStyle(
            fontFamily: kSourceSansPro,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Chat
        menuItem(
          context: context,
          icon: Icons.chat,
          text: 'Chat',
          id: ChatScreen.id,
        ),

        const Divider(
          color: Colors.black54,
          height: kDividerThickness,
        ),
        const Text(
          'Sonstiges',
          style: TextStyle(
            fontFamily: kSourceSansPro,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Wetter Sportplätze
        menuItem(
          context: context,
          icon: Icons.sunny,
          text: 'Wetter Sportplätze',
          id: WeatherScreen.id,
        ),

        // Bedienung Abstreuwagen
        menuItem(
          context: context,
          icon: Icons.library_books,
          text: 'Bedienung Abstreuwagen',
          id: OperationSpreaderTruckScreen.id,
        ),

        // Impressum
        menuItem(
          context: context,
          icon: Icons.info,
          text: 'Impressum',
          id: ImprintScreen.id,
        ),

        const Divider(
          color: Colors.black54,
          height: kDividerThickness,
        ),

        // Einstellungen
        menuItem(
          context: context,
          icon: Icons.settings,
          text: 'Einstellungen',
          id: SettingsScreen.id,
        ),

        const Divider(
          color: Colors.black54,
          height: kDividerThickness,
        ),

        // Abmelden
        ListTile(
          leading: const Icon(
            Icons.logout,
          ),
          title: const Text(
            'Abmelden',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  'Abmelden',
                ),
                content: const Text(
                  'Wollen Sie sich wirklich abmelden?',
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        'JA',
                      );
                      AuthenticationService.signOut(
                        context: context,
                      );
                      Navigator.pushNamed(
                        context,
                        MainScreen.id,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Erfolgreich abgemeldet.',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'JA',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        'NEIN',
                      );
                    },
                    child: const Text(
                      'NEIN',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ]);

  // Loading builder
  Widget loadingBuilder(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      isLoading = false;
      return child;
    }
    return const CircularProgressIndicator(
      color: kSGMColorGreen,
    );
  }
}
