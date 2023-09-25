import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/widgets/info_bar.dart';
import '../constants/box_decoration.dart';
import '../constants/box_size.dart';
import '../constants/color.dart';
import '../constants/divider_thickness.dart';
import '../constants/font_size.dart';
import '../constants/icon_size.dart';
import '../constants/margin.dart';
import '../constants/padding.dart';
import '../models/Player.dart';
import '../screens/squad_screen.dart';

// Widget for the short term training participation
class TrainingParticipationShortTerm extends StatefulWidget {
  const TrainingParticipationShortTerm({super.key});

  @override
  State<TrainingParticipationShortTerm> createState() =>
      TrainingParticipationShortTermState();
}

class TrainingParticipationShortTermState
    extends State<TrainingParticipationShortTerm> {
  final TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  List<Player> players = [];
  List<Player> filteredPlayers = [];
  List<Player> approvedPlayers = [];
  List<Player> declinedPlayers = [];

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
          style: TextStyle(
            decoration: player.isChecked ? null : TextDecoration.lineThrough,
            decorationColor: Colors.black,
            decorationThickness: kDividerThickness,
          ),
        ),
        subtitle: Text(
          player.miscellaneous,
        ),
        trailing: Checkbox(
          activeColor: kSGMColorRed,
          value: player.isChecked,
          onChanged: (newValue) {
            setState(() {
              player.isChecked = newValue!;
            });
            updatePlayerAvailability(
              id: player.id,
              checkboxStatus: player.isChecked,
              context: context,
            );
          },
        ),
      );

  @override
  void initState() {
    super.initState();
    readPlayers().listen((List<Player> playerData) {
      playerData.sort((a, b) {
        final nameComparison = a.name.compareTo(b.name);
        if (nameComparison != 0) {
          return nameComparison;
        }

        return a.name.compareTo(b.name);
      });
      setState(() {
        players = playerData;
        filteredPlayers = List<Player>.from(players);
        approvedPlayers = List<Player>.from(
            players.where((player) => player.isChecked == true)).toList();
        declinedPlayers = List<Player>.from(
            players.where((player) => player.isChecked == false)).toList();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: kBoxWidth,
                      ),
                      Text(
                        '${players.length.toString()} Spieler',
                        style: const TextStyle(
                          fontSize: kFontsizeSubtitle,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(
                        Icons.check,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: kBoxWidth,
                      ),
                      Text(
                        '${approvedPlayers.length.toString()} Spieler',
                        style: const TextStyle(
                          fontSize: kFontsizeSubtitle,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: kBoxWidth,
                      ),
                      Text(
                        '${declinedPlayers.length.toString()} Spieler',
                        style: const TextStyle(
                          fontSize: kFontsizeSubtitle,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
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

// Update player availability
void updatePlayerAvailability(
    {required String id,
    required bool checkboxStatus,
    required BuildContext context}) {
  try {
    final playerAvailability =
        FirebaseFirestore.instance.collection('players').doc(id);
    playerAvailability.update({
      'isChecked': checkboxStatus,
    });
  } catch (e) {
    InfoBar.showInfoBar(
      context: context,
      info: 'Spielerverfügbarkeit konnte nicht aktualisiert werden.',
    );
  }
}
