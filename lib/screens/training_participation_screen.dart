import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/widgets/training_participation_long_term.dart';
import 'package:sgm_du_gu_we/widgets/training_participation_short_term.dart';
import '../constants/color.dart';
import '../constants/padding.dart';

class TrainingParticipationScreen extends StatefulWidget {
  const TrainingParticipationScreen({super.key});

  static const String id = 'training_participation_screen';

  @override
  TrainingParticipationScreenState createState() =>
      TrainingParticipationScreenState();
}

class TrainingParticipationScreenState
    extends State<TrainingParticipationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Trainingsbeteiligung',
          ),
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
          child: Padding(
            padding: EdgeInsets.all(
              kPadding,
            ),
            child: TabBarView(
              children: [
                TrainingParticipationShortTerm(),
                TrainingParticipationLongTerm(),
              ],
            ),
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
}
