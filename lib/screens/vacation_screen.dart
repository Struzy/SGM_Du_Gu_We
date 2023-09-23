import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/icon_size.dart';
import 'package:sgm_du_gu_we/screens/squad_screen.dart';
import 'package:sgm_du_gu_we/widgets/add_vacation.dart';
import '../constants/box_decoration.dart';
import '../constants/box_size.dart';
import '../constants/circle_avatar.dart';
import '../constants/color.dart';
import '../constants/divider_thickness.dart';
import '../constants/elevated_button.dart';
import '../constants/font_family.dart';
import '../constants/font_size.dart';
import '../constants/padding.dart';
import '../models/Player.dart';
import '../models/player_list.dart';
import '../models/vacation.dart';
import '../widgets/update_vacation.dart';

// Type used by the popup menu below
enum SampleItem { itemOne, itemTwo }

class VacationScreen extends StatefulWidget {
  const VacationScreen({super.key});

  static const String id = 'vacation_screen';

  @override
  VacationScreenState createState() => VacationScreenState();
}

class VacationScreenState extends State<VacationScreen> {
  SampleItem? selectedMenu;
  final TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  List<Player> players = [];
  List<Vacation> vacations = [];
  List<Vacation> filteredVacations = [];

  Widget buildVacation(Vacation vacation) => ListTile(
        leading: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            getPath(vacation.name).first.profilePicture,
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
          vacation.name,
        ),
        subtitle: Text(
          '${vacation.startDate} - ${vacation.endDate}',
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
                        child: UpdateVacation(
                          id: vacation.id,
                          startDate: vacation.startDate,
                          endDate: vacation.endDate,
                          name: vacation.name,
                          playerData: players,
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
                              deleteVacation(
                                id: vacation.id,
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Urlaub konnte nicht gelöscht werden.',
                                  ),
                                ),
                              );
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Urlaub wurde erfolgreich gelöscht.',
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
              builder: (context) => VacationDetailScreen(
                profilePicture: getPath(vacation.name).first.profilePicture,
                name: vacation.name,
                startDate: vacation.startDate,
                endDate: vacation.endDate,
              ),
            ),
          );
        },
      );

  @override
  void initState() {
    super.initState();
    readVacations().listen((List<Vacation> vacationData) {
      vacationData.sort((a, b) {
        final dateComparison = a.startDate.compareTo(b.startDate);
        if (dateComparison != 0) {
          return dateComparison;
        }

        // If dates are the same, compare by name
        return a.name.compareTo(b.name);
      });
      setState(() {
        vacations = vacationData;
        filteredVacations = List<Vacation>.from(vacations);
        isLoading = false;
      });
    });
    readPlayers().listen((List<Player> playerData) {
      players = playerData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Urlaub'),
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
                    'Urlaubsliste',
                    style: TextStyle(
                      fontSize: kFontsizeTitle,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${filteredVacations.length.toString()} Urlaube',
                        style: const TextStyle(
                          fontSize: kFontsizeSubtitle,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: AddVacation(
                                  playerData: players,
                                ),
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
                      filterVacations(value);
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
                child: Padding(
                  padding: const EdgeInsets.all(
                    kPadding,
                  ),
                  child: StreamBuilder<List<Vacation>>(
                    stream: readVacations(),
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
                        vacations = snapshot.data!;

                        vacations.sort((a, b) {
                          final startDateComparison =
                              a.startDate.compareTo(b.startDate);
                          if (startDateComparison != 0) {
                            return startDateComparison;
                          }

                          // If start dates are the same, compare by name
                          return a.name.compareTo(b.name);
                        });

                        return RefreshIndicator(
                          onRefresh: refreshData,
                          child: ListView(
                            shrinkWrap: true,
                            children:
                                filteredVacations.map(buildVacation).toList(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
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
  // vacations accordingly
  void filterVacations(String searchQuery) {
    if (searchQuery.isNotEmpty) {
      filteredVacations = vacations
          .where((vacation) => vacation.name.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ))
          .toList();
    } else {
      filteredVacations = List<Vacation>.from(vacations);
    }
    setState(() {
      // Update the UI with the filtered list
    });
  }

  // Refresh list view by pulling down the screen
  Future refreshData() async {
    setState(() {
      readVacations();
    });
  }
}

class VacationDetailScreen extends StatelessWidget {
  VacationDetailScreen(
      {super.key,
      required this.profilePicture,
      required this.name,
      required this.startDate,
      required this.endDate});

  final String profilePicture;
  final String name;
  final String startDate;
  final String endDate;

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Urlaubsinformationen',
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
                  'Urlaub vom $startDate bis $endDate',
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

// Get all the players
List<Player> getPlayers() {
  PlayerList playerList = PlayerList();

  return playerList.playerList;
}

// Read all vacations
Stream<List<Vacation>> readVacations() => FirebaseFirestore.instance
    .collection('vacations')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Vacation.fromJson(doc.data())).toList());

// Delete vacation
void deleteVacation({required String id}) {
  final vacation = FirebaseFirestore.instance.collection('vacations').doc(id);
  vacation.delete();
}
