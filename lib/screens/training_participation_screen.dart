import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/screens/squad_screen.dart';
import 'package:sgm_du_gu_we/widgets/training_participation_long_term.dart';
import 'package:sgm_du_gu_we/widgets/training_participation_short_term.dart';
import '../constants/color.dart';
import '../models/Player.dart';
import '../services/authentication_service.dart';
import '../services/info_bar_service.dart';

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
  late User? loggedInUser;
  bool isEntitled = false;

  @override
  void initState() {
    super.initState();
    loggedInUser = AuthenticationService.getUser(context);
    isEntitled = assessEntitlement();
  }

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
                if (isEntitled) {
                  await undoPlayerAvailability(
                    context: context,
                  );
                  setState(() {
                    const TrainingParticipationShortTerm();
                  });
                  InfoBarService.showInfoBar(
                    context: context,
                    info: 'Spielerverfügbarkeit wurde zurückgesetzt.',
                  );
                } else {
                  InfoBarService.showInfoBar(
                    context: context,
                    info:
                        'Es liegt keine Berechtigung für das Zurücksetzen der Spielerverfügbarkeit vor.',
                  );
                }
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

  // Check whether user is entitled to perform modifications
  bool assessEntitlement() {
    if (loggedInUser?.displayName == 'Christian Krauss' ||
        loggedInUser?.displayName == 'Max Kleinhans' ||
        loggedInUser?.displayName == 'Maurice Merz') {
      return true;
    } else {
      return false;
    }
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
      InfoBarService.showInfoBar(
        context: context,
        info: 'Spielerverfügbarkeit konnte nicht zurückgesetzt werden.',
      );
    }
  }
}
