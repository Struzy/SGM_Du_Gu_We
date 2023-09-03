import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/models/Player.dart';
import 'package:sgm_du_gu_we/models/player_list.dart';
import 'package:sgm_du_gu_we/constants/circle_avatar.dart';
import '../constants/box_size.dart';
import '../constants/color.dart';
import '../constants/divider_thickness.dart';
import '../constants/font_family.dart';
import '../constants/font_size.dart';
import '../constants/padding.dart';
import '../widgets/navigation_drawer.dart' as nav;

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
  void initState() {
    super.initState();
    filteredPlayers.sort((a, b) {
      final startDateComparison =
      a.name.compareTo(b.name);

      return startDateComparison;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const nav.NavigationDrawer(),
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
                  hintText: 'Nach Namen durchsuchen...',
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SquadDetailScreen(
                              profilePicture: player.profilePicture,
                              name: player.name,
                            ),
                          ),
                        );
                      },
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
                        player.name,
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
          .where((player) => player.name.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ))
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

class SquadDetailScreen extends StatelessWidget {
  SquadDetailScreen(
      {super.key, required this.profilePicture, required this.name});

  final String profilePicture;
  final String name;

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Spielerinformationen',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: kRadius,
                  child: ClipOval(
                    child: Image.network(
                      profilePicture,
                      width: kRadius * 2,
                      height: kRadius * 2,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          isLoading = false;
                          return child;
                        }
                        return const CircularProgressIndicator(
                          color: kSGMColorGreen,
                        );
                      },
                    ),
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: kPacifico,
                    fontSize: kFontsizeTitle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                  width: 150.0,
                  child: Divider(
                    thickness: kDividerThickness,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
