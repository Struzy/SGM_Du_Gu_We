import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/models/Player.dart';
import 'package:sgm_du_gu_we/models/player_list.dart';
import 'package:sgm_du_gu_we/constants/circle_avatar.dart';
import '../constants/box_decoration.dart';
import '../constants/box_size.dart';
import '../constants/color.dart';
import '../constants/divider_thickness.dart';
import '../constants/font_family.dart';
import '../constants/font_size.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';

class SquadScreen extends StatefulWidget {
  const SquadScreen({super.key});

  static const String id = 'squad_screen';

  @override
  SquadScreenState createState() => SquadScreenState();
}

class SquadScreenState extends State<SquadScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  List<Player> players = [];
  List<Player> filteredPlayers = [];

  Widget buildPlayer(Player player) => ListTile(
        leading: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
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
        ),
        title: Text(
          player.name,
        ),
        subtitle: Text(
          player.miscellaneous,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SquadDetailScreen(
                profilePicture: player.profilePicture,
                name: player.name,
                miscellaneous: player.miscellaneous,
              ),
            ),
          );
        },
      );

  @override
  void initState() {
    super.initState();
    readPlayers().listen((List<Player> playerData) {
      playerData.sort((a, b) {
        final nameComparison =
        a.name.compareTo(b.name);
        if (nameComparison != 0) {
          return nameComparison;
        }

        return a.name.compareTo(b.name);
      });
      setState(() {
        players = playerData;
        filteredPlayers = List<Player>.from(players);
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kader'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(
                kPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: kIconList,
                    child: Icon(
                      Icons.list,
                      size: kIconList,
                      color: kSGMColorGreenLight,
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  const Text(
                    'Spielerliste',
                    style: TextStyle(
                      fontSize: kFontsizeTitle,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${filteredPlayers.length.toString()} Spieler',
                    style: const TextStyle(
                      fontSize: kFontsizeSubtitle,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
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
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      kBorderRadiusContainer,
                    ),
                    topRight: Radius.circular(
                      kBorderRadiusContainer,
                    ),
                  ),
                ),
                child: StreamBuilder<List<Player>>(
                  stream: readPlayers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Beim Laden der Einträge ist ein Fehler aufgetreten.',
                          ),
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      players = snapshot.data!;

                      players.sort((a, b) {
                        final nameComparison = a.name.compareTo(b.name);
                        if (nameComparison != 0) {
                          return nameComparison;
                        }

                        // If start dates are the same, compare by name
                        return a.name.compareTo(b.name);
                      });

                      return RefreshIndicator(
                        onRefresh: refreshData,
                        child: ListView(
                          shrinkWrap: true,
                          children: filteredPlayers.map(buildPlayer).toList(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
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

  // Refresh list view by pulling down the screen
  Future refreshData() async {
    setState(() {
      readPlayers();
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
      {super.key,
      required this.profilePicture,
      required this.name,
      required this.miscellaneous});

  final String profilePicture;
  final String name;
  final String miscellaneous;

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
                  height: kBoxHeightDetailScreen,
                  width: kBoxWidthDetailScreen,
                  child: Divider(
                    thickness: kDividerThickness,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  miscellaneous,
                  style: const TextStyle(
                    fontSize: kFontsizeSubtitle,
                    fontWeight: FontWeight.bold,
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

// Read all players
Stream<List<Player>> readPlayers() => FirebaseFirestore.instance
    .collection('players')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Player.fromJson(doc.data())).toList());
