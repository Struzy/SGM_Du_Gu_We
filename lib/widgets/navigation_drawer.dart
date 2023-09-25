import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/screens/finance_screen.dart';
import 'package:sgm_du_gu_we/screens/home_screen.dart';
import 'package:sgm_du_gu_we/screens/settings_screen.dart';
import 'package:sgm_du_gu_we/screens/training_participation_screen.dart';
import 'package:sgm_du_gu_we/screens/weather_screen.dart';
import '../constants/color.dart';
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
          top: 24 + MediaQuery.of(context).padding.top,
          bottom: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 52,
              child: ClipOval(
                child: Image.network(
                  loggedInUser?.photoURL ?? kDefaultAvatarLogo,
                  fit: BoxFit.cover,
                  height: 104,
                  width: 104,
                  loadingBuilder: loadingBuilder,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              loggedInUser?.displayName ?? '',
              style: const TextStyle(
                fontSize: 28,
                color: Colors.black,
              ),
            ),
            Text(
              loggedInUser?.email ?? '',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Column(children: [
        // Hauptmenü
        ListTile(
          leading: const Icon(
            Icons.home,
          ),
          title: const Text(
            'Hauptmenü',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              HomeScreen.id,
            );
          },
        ),

        // Fußballverein
        ListTile(
          leading: const Icon(
            Icons.sports_soccer,
          ),
          title: const Text(
            'Fußballverein',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              FootballClubScreen.id,
            );
          },
        ),

        // Kader
        ListTile(
          leading: const Icon(
            Icons.person,
          ),
          title: const Text(
            'Kader',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              SquadScreen.id,
            );
          },
        ),

        // 1. Mannschaft
        ListTile(
          leading: const Icon(
            Icons.person,
          ),
          title: const Text(
            '1. Mannschaft',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              FirstSquadScreen.id,
            );
          },
        ),

        // 2. Mannschaft
        ListTile(
          leading: const Icon(
            Icons.person,
          ),
          title: const Text(
            '2. Mannschaft',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              SecondSquadScreen.id,
            );
          },
        ),

        // Kreisliga B2 Württemberg
        ListTile(
          leading: const Icon(
            Icons.sports,
          ),
          title: const Text(
            'Kreisliga B2 Württemberg',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              FirstSquadLeagueScreen.id,
            );
          },
        ),

        // Kreisliga C3 Württemberg
        ListTile(
          leading: const Icon(
            Icons.sports,
          ),
          title: const Text(
            'Kreisliga C3 Württemberg',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              SecondSquadLeagueScreen.id,
            );
          },
        ),

        // Baarpokal
        ListTile(
          leading: const Icon(
            Icons.sports,
          ),
          title: const Text(
            'Baarpokal',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              BaarCupScreen.id,
            );
          },
        ),

        // Trainingsbeteiligung
        ListTile(
          leading: const Icon(
            Icons.sports,
          ),
          title: const Text(
            'Trainingsbeteiligung',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              TrainingParticipationScreen.id,
            );
          },
        ),

        // Strafen
        ListTile(
          leading: const Icon(
            Icons.sports,
          ),
          title: const Text(
            'Strafen',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              PenaltyScreen.id,
            );
          },
        ),

        // Urlaub
        ListTile(
          leading: const Icon(
            Icons.sports,
          ),
          title: const Text(
            'Urlaub',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              VacationScreen.id,
            );
          },
        ),

        // Strafenkatalog
        ListTile(
          leading: const Icon(
            Icons.sports,
          ),
          title: const Text(
            'Strafenkatalog',
          ),
          onTap: () async {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              PenaltyCatalogScreen.id,
            );
          },
        ),

        // Vorbereitungsplan
        ListTile(
          leading: const Icon(
            Icons.sports,
          ),
          title: const Text(
            'Vorbereitungsplan',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              PreparationPlanScreen.id,
            );
          },
        ),

        // Abstreuplan
        ListTile(
          leading: const Icon(
            Icons.sports,
          ),
          title: const Text(
            'Abstreuplan',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              SprinklePlanScreen.id,
            );
          },
        ),

        // Mediathek
        ListTile(
          leading: const Icon(
            Icons.library_music,
          ),
          title: const Text(
            'Mediathek',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              MediaPlayerScreen.id,
            );
          },
        ),

        // Videothek
        ListTile(
          leading: const Icon(
            Icons.video_collection,
          ),
          title: const Text(
            'Videothek',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              VideoPlayerScreen.id,
            );
          },
        ),

        // Galerie
        ListTile(
          leading: const Icon(
            Icons.image,
          ),
          title: const Text(
            'Galerie',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              GalleryScreen.id,
            );
          },
        ),

        // Liedtexte
        ListTile(
          leading: const Icon(
            Icons.lyrics,
          ),
          title: const Text(
            'Liedtexte',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              LyricsScreen.id,
            );
          },
        ),

        // Finanzen
        ListTile(
          leading: const Icon(
            Icons.euro,
          ),
          title: const Text(
            'Finanzen',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              FinanceScreen.id,
            );
          },
        ),

        // Spielerstatistik
        ListTile(
          leading: const Icon(
            Icons.sports,
          ),
          title: const Text(
            'Spielerstatistik',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              PlayerStatisticsScreen.id,
            );
          },
        ),

        // Chat
        ListTile(
          leading: const Icon(
            Icons.chat,
          ),
          title: const Text(
            'Chat',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              ChatScreen.id,
            );
          },
        ),

        // Einstellungen
        ListTile(
          leading: const Icon(
            Icons.settings,
          ),
          title: const Text(
            'Einstellungen',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              SettingsScreen.id,
            );
          },
        ),

        // Sonstiges
        ListTile(
          leading: const Icon(
            Icons.miscellaneous_services,
          ),
          title: const Text(
            'Sonstiges',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              MiscellaneousScreen.id,
            );
          },
        ),

        // Impressum
        ListTile(
          leading: const Icon(
            Icons.contact_mail,
          ),
          title: const Text(
            'Impressum',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              ImprintScreen.id,
            );
          },
        ),

        // Wetter Sportplätze
        ListTile(
          leading: const Icon(
            Icons.sunny,
          ),
          title: const Text(
            'Wetter Sportplätze',
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
            Navigator.pushNamed(
              context,
              WeatherScreen.id,
            );
          },
        ),

        const Divider(
          color: Colors.black54,
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
  Widget loadingBuilder(BuildContext context, Widget child,
      ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      isLoading = false;
      return child;
    }
    return const CircularProgressIndicator(
      color: kSGMColorGreen,
    );
  }
}
