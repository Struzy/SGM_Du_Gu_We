import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widgets/navigation_drawer.dart';

class FirstSquadLeagueScreen extends StatefulWidget {
  const FirstSquadLeagueScreen({super.key});

  static const String id = 'first_squad_league_screen';

  @override
  FirstSquadLeagueScreenState createState() => FirstSquadLeagueScreenState();
}

class FirstSquadLeagueScreenState extends State<FirstSquadLeagueScreen> {
  int progress = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Kreisliga A2 Schwarzwald'),
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            Expanded(
              child: WebView(
                initialUrl:
                    'https://www.fussball.de/spieltagsuebersicht/kreisliga-a2-bezirk-schwarzwald-kl-kreisliga-a-herren-saison2223-wuerttemberg/-/staffel/02IL01JN30000004VS5489B3VVETK79U-G#!/',
                javascriptMode: JavascriptMode.unrestricted,
                onProgress: (int newProgress) {
                  setState(() {
                    progress = newProgress;
                  });
                },
                onPageFinished: (String url) {
                  setState(() {
                    progress = 0;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
