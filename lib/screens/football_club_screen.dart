import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widgets/navigation_drawer.dart' as nav;

class FootballClubScreen extends StatefulWidget {
  const FootballClubScreen({super.key});

  static const String id = 'football_club_screen';

  @override
  FootballClubScreenState createState() => FootballClubScreenState();
}

class FootballClubScreenState extends State<FootballClubScreen> {
  int progress = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const nav.NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Fußballverein'),
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
                    'https://www.fussball.de/verein/sv-durchhausen-wuerttemberg/-/id/00ES8GNAUG00003CVV0AG08LVUPGND5I#!/',
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
