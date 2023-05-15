import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/font_size.dart';
import '../constants/box_size.dart';
import '../constants/color.dart';
import '../constants/font_family.dart';
import '../constants/padding.dart';
import '../services/authentication_service.dart';
import 'main_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavigationDrawer(),
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
                children: const <Widget>[
                  Text(
                    'Herzlich willkommen bei der',
                    style: TextStyle(
                      fontSize: kFontsizeSubtitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'SGM',
                    style: TextStyle(
                      fontFamily: kPacifico,
                      fontSize: kFontsizeTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Durchhausen',
                    style: TextStyle(
                      fontFamily: kPacifico,
                      fontSize: kFontsizeTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Gunningen',
                    style: TextStyle(
                      fontFamily: kPacifico,
                      fontSize: kFontsizeTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Weigheim',
                    style: TextStyle(
                      fontFamily: kPacifico,
                      fontSize: kFontsizeTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'Durchhausen/Gunningen:',
                    style: TextStyle(
                      fontSize: kFontsizeSubtitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Image(
                    image: NetworkImage(
                      'https://images.media.fussball.de/userfiles/n/E/W/anvdDGNaRVzrCCDy2r5T70_t3.jpg',
                    ),
                  ),
                  SizedBox(
                    height: kBoxHeight + 20.0,
                  ),
                  Text(
                    'Weigheim:',
                    style: TextStyle(
                      fontSize: kFontsizeSubtitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Image(
                    image: NetworkImage(
                      'https://images.media.fussball.de/userfiles/w/e/K/sVNqBzZhx5ySXy1Fjc9i10_t3.jpg',
                    ),
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
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            Text(
              'manuel.struzyna@outlook.de',
              style: TextStyle(fontSize: 16, color: Colors.white),
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
            Navigator.pushNamed(context, HomeScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports_soccer),
          title: const Text(
            'Fußballverein',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text(
            '1. Mannschaft',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, MainScreen.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text(
            '2. Mannschaft',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports),
          title: const Text(
            'Kreisliga A2 Schwarzwald',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports),
          title: const Text(
            'Kreisliga B2 Schwarzwald',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports),
          title: const Text(
            'Trainingsbeteiligung',
          ),
          onTap: () {
            Navigator.pop(context);
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
            'Nominerungen',
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
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports),
          title: const Text(
            'Vorbereitungsplan',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports),
          title: const Text(
            'Abstreuplan',
          ),
          onTap: () {
            Navigator.pop(context);
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
          leading: const Icon(Icons.contact_mail),
          title: const Text(
            'Liedtexte',
          ),
          onTap: () {
            Navigator.pop(context);
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
            'Ewige Spielerliste',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.chat),
          title: const Text(
            'Chat',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, MainScreen.id);
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
          leading: const Icon(Icons.contact_mail),
          title: const Text(
            'Impressum',
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, MainScreen.id);
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
            AuthenticationService.signOut(context: context);
            // TODO: Abfrage, ob man sich wirklich abmelden will
            Navigator.pushNamed(context, MainScreen.id);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Erfolgreich abgemeldet'),
              ),
            );
          },
        ),
      ]);
}
