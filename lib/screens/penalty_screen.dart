import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/classes/Player.dart';
import 'package:sgm_du_gu_we/classes/player_list.dart';
import '../constants/circle_avatar.dart';
import '../constants/color.dart';
import '../constants/padding.dart';

class PenaltyScreen extends StatefulWidget {
  const PenaltyScreen({super.key});

  static const String id = 'penalty_screen';

  @override
  PenaltyScreenState createState() => PenaltyScreenState();
}

class PenaltyScreenState extends State<PenaltyScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    List<Player> players = getPlayers();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Offene Strafen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: ListView.builder(
            itemCount: players.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(
                  players[index].profilePicture,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      isLoading = false;
                      return child;
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                title: Text(
                    '${players[index].surname}, ${players[index].forename}'),
                subtitle: Text('Einsätze: ${players[index].appearances}'),
                trailing: const Icon(Icons.arrow_forward),
                onLongPress: () {
                  // TODO: Handle when icon has been longly pressed
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // Get all the players
  List<Player> getPlayers() {
    PlayerList playerList = PlayerList();

    return playerList.playerList;
  }
}
