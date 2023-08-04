import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants/url.dart';
import '../widgets/navigation_drawer.dart' as nav;

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
        drawer: const nav.NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Kreisliga B2 Württemberg'),
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
                kFirstSquadLeagueUrl,
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
