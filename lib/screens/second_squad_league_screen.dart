import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants/url.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kreisliga C3 Württemberg'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            Expanded(
              child: WebView(
                initialUrl:
                kSecondSquadLeagueUrl,
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
