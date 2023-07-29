import 'package:flutter/material.dart';
import '../constants/box_size.dart';
import '../constants/padding.dart';
import '../widgets/navigation_drawer.dart';

class LyricsScreen extends StatefulWidget {
  const LyricsScreen({super.key});

  static const String id = 'lyrics_screen';

  @override
  LyricsScreenState createState() => LyricsScreenState();
}

class LyricsScreenState extends State<LyricsScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Liedtexte'),
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
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Liedtexte%2Flyrics1.PNG?alt=media&token=c9e1e397-cc64-49b9-8c71-7f352d4c55e9',
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
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Liedtexte%2Flyrics2.PNG?alt=media&token=c34f9a8c-fccd-4f12-acc1-834100365ea8',
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
          )),
        ),
      ),
    );
  }
}
