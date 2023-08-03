import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widgets/navigation_drawer.dart' as nav;

class SecondSquadLeagueScreen extends StatefulWidget {
  const SecondSquadLeagueScreen({super.key});

  static const String id = 'second_squad_league_screen';

  @override
  SecondSquadLeagueScreenState createState() => SecondSquadLeagueScreenState();
}

class SecondSquadLeagueScreenState extends State<SecondSquadLeagueScreen> {
  int progress = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const nav.NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Kreisliga B2 Schwarzwald'),
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
                'https://www.fussball.de/spieltagsuebersicht/kreisliga-b2-bezirk-schwarzwald-kl-kreisliga-b-herren-saison2223-wuerttemberg/-/staffel/02IL02JE68000005VS5489B3VVETK79U-G#!/',
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
