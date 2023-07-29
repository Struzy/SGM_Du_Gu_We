import 'package:flutter/material.dart';
import '../constants/box_size.dart';
import '../constants/padding.dart';
import '../widgets/navigation_drawer.dart';

class PlayerStatisticsScreen extends StatefulWidget {
  const PlayerStatisticsScreen({super.key});

  static const String id = 'player_statistics_screen';

  @override
  PlayerStatisticsScreenState createState() => PlayerStatisticsScreenState();
}

class PlayerStatisticsScreenState extends State<PlayerStatisticsScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Spielerstatistik'),
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
                  'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Spielerstatistik%2Fplayer_statistics1.PNG?alt=media&token=6d1985c2-f7f6-43b8-b133-8aa11af8e471',
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
                  height: kBoxHeight,
                ),
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Spielerstatistik%2Fplayer_statistics2.PNG?alt=media&token=425a5af5-92df-4804-8d37-fcf74f993e9f',
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
                  height: kBoxHeight,
                ),
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Spielerstatistik%2Fplayer_statistics3.PNG?alt=media&token=73a5604c-5099-4557-add9-551b69cfaf05',
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
                  height: kBoxHeight,
                ),
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Spielerstatistik%2Fplayer_statistics4.PNG?alt=media&token=1a136d22-48ba-45ba-8edc-d4d21045a550',
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
                  height: kBoxHeight,
                ),
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Spielerstatistik%2Fplayer_statistics5.PNG?alt=media&token=95bebfe1-f236-4ed2-b2b9-58eb3ff850c7',
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
                  height: kBoxHeight,
                ),
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Spielerstatistik%2Fplayer_statistics6.PNG?alt=media&token=27c7fcd0-9d0e-448f-9667-5ab835921e89',
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
