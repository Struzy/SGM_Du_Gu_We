import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/screens/squad_screen.dart';
import 'package:sgm_du_gu_we/widgets/training_participation_long_term.dart';
import 'package:sgm_du_gu_we/widgets/training_participation_short_term.dart';
import '../constants/color.dart';
import '../models/Player.dart';
import '../widgets/info_bar.dart';

class TrainingParticipationScreen extends StatefulWidget {
  const TrainingParticipationScreen({super.key});

  static const String id = 'training_participation_screen';

  @override
  TrainingParticipationScreenState createState() =>
      TrainingParticipationScreenState();
}

class TrainingParticipationScreenState
    extends State<TrainingParticipationScreen> {
  List<Player> players = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Trainingsbeteiligung',
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.undo,
              ),
              onPressed: () async {
                await undoPlayerAvailability(
                  context: context,
                );
                setState(() {
                  const TrainingParticipationShortTerm();
                });
                InfoBar.showInfoBar(
                  context: context,
                  info: 'Spielerverfügbarkeit wurde zurückgesetzt.',
                );
              },
            ),
          ],
          bottom: const TabBar(
            indicatorColor: kSGMColorRed,
            tabs: [
              Tab(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.event_available,
                      color: Colors.black,
                    ),
                    Text(
                      'Kurzfristig',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.timeline,
                      color: Colors.black,
                    ),
                    Text(
                      'Langfristig',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
              TrainingParticipationShortTerm(),
              TrainingParticipationLongTerm(),
            ],
          ),
        ),
      ),
    );
  }

  // Show snack bar
  void showSnackBar(String snackBarText) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          snackBarText,
        ),
      ),
    );
  }

  // Update player availability
  Future<void> undoPlayerAvailability({required BuildContext context}) async {
    try {
      readPlayers().listen((List<Player> playerData) {
        players = playerData;
      });

      for (var player in players) {
        final playerAvailability =
            FirebaseFirestore.instance.collection('players').doc(player.id);
        playerAvailability.update({
          'isChecked': false,
        });
      }
    } catch (e) {
      InfoBar.showInfoBar(
        context: context,
        info: 'Spielerverfügbarkeit konnte nicht zurückgesetzt werden.',
      );
    }
  }
}
