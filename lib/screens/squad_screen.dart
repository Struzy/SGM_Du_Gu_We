import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/classes/Player.dart';
import 'package:sgm_du_gu_we/classes/player_list.dart';
import '../constants/box_size.dart';
import '../constants/padding.dart';

List<Player> players = getPlayers();
List<Player> filteredPlayers = List<Player>.from(players);

class SquadScreen extends StatefulWidget {
  const SquadScreen({super.key});

  static const String id = 'squad_screen';

  @override
  SquadScreenState createState() => SquadScreenState();
}

class SquadScreenState extends State<SquadScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kader'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                controller: searchController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.search,
                  ),
                  hintText: 'Kader nach Nachnamen durchsuchen...',
                ),
                onChanged: (value) {
                  filterPlayers(value);
                },
              ),
              const SizedBox(
                height: kBoxHeight,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredPlayers.length,
                  itemBuilder: (context, index) {
                    final player = filteredPlayers[index];

                    return ListTile(
                      leading: Image.network(
                        player.profilePicture,
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
                        '${player.surname}, ${player.forename}',
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Filter the list based on a search query
  // This function will take the search query as input and update the list
  // players accordingly
  void filterPlayers(String searchQuery) {
    if (searchQuery.isNotEmpty) {
      filteredPlayers = players
          .where(
            (player) => player.surname.contains(
              searchQuery,
            ),
          )
          .toList();
    } else {
      filteredPlayers = List<Player>.from(players);
    }
    setState(() {
      // Update the UI with the filtered list
    });
  }
}

// Get all the players
List<Player> getPlayers() {
  PlayerList playerList = PlayerList();

  return playerList.playerList;
}
