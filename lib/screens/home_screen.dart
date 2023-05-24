import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/font_size.dart';
import 'package:sgm_du_gu_we/screens/first_squad_league_screen.dart';
import 'package:sgm_du_gu_we/screens/first_squad_screen.dart';
import 'package:sgm_du_gu_we/screens/football_club_screen.dart';
import 'package:sgm_du_gu_we/screens/imprint_screen.dart';
import 'package:sgm_du_gu_we/screens/penalty_catalog_screen.dart';
import 'package:sgm_du_gu_we/screens/penalty_screen.dart';
import 'package:sgm_du_gu_we/screens/player_statistics_screen.dart';
import 'package:sgm_du_gu_we/screens/preparation_plan_screen.dart';
import 'package:sgm_du_gu_we/screens/second_squad_league_screen.dart';
import 'package:sgm_du_gu_we/screens/second_squad_screen.dart';
import 'package:sgm_du_gu_we/screens/sprinkle_plan_screen.dart';
import '../constants/box_size.dart';
import '../constants/color.dart';
import '../constants/font_family.dart';
import '../constants/padding.dart';
import '../services/authentication_service.dart';
import 'baar_cup_screen.dart';
import 'chat_screen.dart';
import 'lyrics_screen.dart';
import 'main_screen.dart';
import 'miscellaneous_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = 'home_screen';

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Hauptmenü'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Herzlich willkommen bei der',
                    style: TextStyle(
                      fontSize: kFontsizeSubtitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  const Text(
                    'SGM',
                    style: TextStyle(
                      fontFamily: kPacifico,
                      fontSize: kFontsizeTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Durchhausen',
                    style: TextStyle(
                      fontFamily: kPacifico,
                      fontSize: kFontsizeTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Gunningen',
                    style: TextStyle(
                      fontFamily: kPacifico,
                      fontSize: kFontsizeTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Weigheim',
                    style: TextStyle(
                      fontFamily: kPacifico,
                      fontSize: kFontsizeTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  const Text(
                    'Durchhausen/Gunningen:',
                    style: TextStyle(
                      fontSize: kFontsizeSubtitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  Image.network(
                    'https://images.media.fussball.de/userfiles/n/E/W/anvdDGNaRVzrCCDy2r5T70_t3.jpg',
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        isLoading = false;
                        return child;
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  const SizedBox(
                    height: kBoxHeight + 20.0,
                  ),
                  const Text(
                    'Weigheim:',
                    style: TextStyle(
                      fontSize: kFontsizeSubtitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  Image.network(
                    'https://images.media.fussball.de/userfiles/w/e/K/sVNqBzZhx5ySXy1Fjc9i10_t3.jpg',
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        isLoading = false;
                        return child;
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

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
          children: const [
            CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(
                  'https://cdn.fussball.de/public/02IV7D16VC000000VS5489B8VV1J2EVP.web'),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Manuel Struzyna',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            Text(
              'manuel.struzyna@outlook.de',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Column(children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text(
            'Hauptmenü',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports_soccer),
          title: const Text(
            'Fußballverein',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, FootballClubScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text(
            '1. Mannschaft',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, FirstSquadScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text(
            '2. Mannschaft',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, SecondSquadScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports),
          title: const Text(
            'Kreisliga A2 Schwarzwald',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, FirstSquadLeagueScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports),
          title: const Text(
            'Kreisliga B2 Schwarzwald',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, SecondSquadLeagueScreen.id);
          },
        ),
    ListTile(
      leading: const Icon(Icons.sports),
      title: const Text(
        'Kreisliga B2 Schwarzwald',
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, SecondSquadLeagueScreen.id);
      },
    ),
        ListTile(
          leading: const Icon(Icons.sports),
          title: const Text(
            'Baarpokal',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, BaarCupScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports),
          title: const Text(
            'Trainingsplanung',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports),
          title: const Text(
            'Nominierungen',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports),
          title: const Text(
            'Strafen',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, PenaltyScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports),
          title: const Text(
            'Urlaub',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports),
          title: const Text(
            'Strafenkatalog',
          ),
          onTap: () async {
            Navigator.pop(context);
            Navigator.pushNamed(context, PenaltyCatalogScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports),
          title: const Text(
            'Vorbereitungsplan',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, PreparationPlanScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports),
          title: const Text(
            'Abstreuplan',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, SprinklePlanScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.library_music),
          title: const Text(
            'Mediathek',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.video_collection),
          title: const Text(
            'Videothek',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text(
            'Galerie',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.lyrics),
          title: const Text(
            'Liedtexte',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, LyricsScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.euro),
          title: const Text(
            'Finanzen',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports),
          title: const Text(
            'Spielerstatistik',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, PlayerStatisticsScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.chat),
          title: const Text(
            'Chat',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, ChatScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text(
            'Einstellungen',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.miscellaneous_services),
          title: const Text(
            'Sonstiges',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, MiscellaneousScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.contact_mail),
          title: const Text(
            'Impressum',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, ImprintScreen.id);
          },
        ),
        const Divider(
          color: Colors.black54,
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text(
            'Abmelden',
          ),
          onTap: () {
            Navigator.pop(context);
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Abmelden'),
                content: const Text('Wollen Sie sich wirklich abmelden?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'JA');
                      AuthenticationService.signOut(context: context);
                      Navigator.pushNamed(context, MainScreen.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Erfolgreich abgemeldet.'),
                        ),
                      );
                    },
                    child: const Text('JA'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'NEIN');
                    },
                    child: const Text('NEIN'),
                  ),
                ],
              ),
            );
          },
        ),
      ]);
}
