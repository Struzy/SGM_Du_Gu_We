import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/models/amount.dart';
import '../constants/box_size.dart';
import '../constants/circle_avatar.dart';
import '../constants/color.dart';
import '../constants/divider_thickness.dart';
import '../constants/elevated_button.dart';
import '../constants/font_family.dart';
import '../constants/font_size.dart';
import '../constants/padding.dart';
import '../models/Player.dart';
import '../models/offense.dart';
import '../models/penalty.dart';
import '../models/player_list.dart';
import '../services/database_delete_service.dart';
import '../services/database_read_service.dart';
import '../widgets/add_penalty.dart';
import '../widgets/navigation_drawer.dart' as nav;
import '../widgets/update_penalty.dart';

List<Player> players = getPlayers();
List<Penalty> penalties = [];
List<Penalty> filteredPenalties = List<Penalty>.from(penalties);

// Type used by the popup menu below
enum SampleItem { itemOne, itemTwo }

class PenaltyScreen extends StatefulWidget {
  const PenaltyScreen({super.key});

  static const String id = 'penalty_screen';

  @override
  PenaltyScreenState createState() => PenaltyScreenState();
}

class PenaltyScreenState extends State<PenaltyScreen> {
  SampleItem? selectedMenu;
  final TextEditingController searchController = TextEditingController();

  bool isLoading = true;

  Widget buildPenalty(Penalty penalty) => ListTile(
        leading: Image.network(
          getPath(penalty.name).first.profilePicture,
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
          penalty.name,
        ),
        subtitle: Text(
          penalty.date,
        ),
        trailing: PopupMenuButton<SampleItem>(
          onSelected: (SampleItem item) {
            setState(() {
              selectedMenu = item;
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
            PopupMenuItem<SampleItem>(
              value: SampleItem.itemOne,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: UpdatePenalty(
                          id: penalty.id,
                          date: penalty.date,
                          name: penalty.name,
                          offense: penalty.offense,
                          amount: penalty.amount,
                        ),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Aktualisieren',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            PopupMenuItem<SampleItem>(
              value: SampleItem.itemTwo,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'Löschen',
                      ),
                      content: const Text(
                        'Wollen Sie wirklich den Eintrag löschen?',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                              'JA',
                            );
                            try {
                              deletePenalty(
                                id: penalty.id,
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Strafe konnte nicht gelöscht werden.',
                                  ),
                                ),
                              );
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Strafe wurde erfolgreich gelöscht.',
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'JA',
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                              'NEIN',
                            );
                          },
                          child: const Text(
                            'NEIN',
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  'Löschen',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PenaltyDetailScreen(
                profilePicture: getPath(penalty.name).first.profilePicture,
                date: penalty.date,
                name: penalty.name,
                offense: penalty.offense,
                amount: penalty.amount,
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const nav.NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Strafen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  filterPenalties(value);
                },
              ),
              const SizedBox(
                height: kBoxHeight,
              ),
              StreamBuilder<List<Penalty>>(
                stream: readPenalties(),
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
                    penalties = snapshot.data!;
                    penalties.sort((a, b) {
                      final dateComparison = b.date.compareTo(a.date);
                      if (dateComparison != 0) {
                        return dateComparison;
                      }

                      // If start dates are the same, compare by name
                      return a.name.compareTo(b.name);
                    });

                    return Expanded(
                      child: ListView(
                        children: filteredPenalties.map(buildPenalty).toList(),
                      ),
                    );
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: const AddPenalty(),
                          ),
                        ),
                      );
                    },
                    foregroundColor: Colors.black,
                    backgroundColor: kSGMColorRed,
                    elevation: kElevation,
                    child: const Icon(
                      Icons.add,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Get path of profile picture
  List<Player> getPath(String name) {
    List<Player> path = players
        .where((player) => player.name.contains(
              name,
            ))
        .toList();

    return path;
  }

  // Filter the list based on a search query
  // This function will take the search query as input and update the list
  // penalties accordingly
  void filterPenalties(String searchQuery) {
    if (searchQuery.isNotEmpty) {
      filteredPenalties = penalties
          .where((penalty) => penalty.name.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ))
          .toList();
    } else {
      filteredPenalties = List<Penalty>.from(penalties);
    }
    setState(() {
      // Update the UI with the filtered list
    });
  }
}

class PenaltyDetailScreen extends StatelessWidget {
  PenaltyDetailScreen(
      {super.key,
      required this.profilePicture,
      required this.date,
      required this.name,
      required this.offense,
      required this.amount});

  final String profilePicture;
  final String date;
  final String name;
  final String offense;
  final String amount;

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Strafeninformationen',
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
                Text(
                  '$date',
                  style: const TextStyle(
                    fontSize: kFontsizeSubtitle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: kBoxHeight,
                ),
                Text(
                  '$offense',
                  style: const TextStyle(
                    fontSize: kFontsizeSubtitle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: kBoxHeight,
                ),
                Text(
                  '$amount',
                  style: const TextStyle(
                    fontSize: kFontsizeSubtitle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: kBoxHeight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Get all the players
List<Player> getPlayers() {
  PlayerList playerList = PlayerList();

  return playerList.playerList;
}

// Get all the offenses
List<String> getOffenses() {
  Offense offenses = Offense();

  List<String> list = [];

  for (var offense in offenses.offensesList) {
    list.add(offense);
  }

  return list;
}

// Get all the amounts
List<String> getAmounts() {
  Amount amounts = Amount();

  List<String> list = [];

  for (var amount in amounts.amountsList) {
    list.add(amount);
  }

  return list;
}
