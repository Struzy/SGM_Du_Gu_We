import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/box_size.dart';
import '../constants/circle_avatar.dart';
import '../constants/color.dart';
import '../constants/divider_thickness.dart';
import '../constants/elevated_button.dart';
import '../constants/font_family.dart';
import '../constants/font_size.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';
import '../models/Player.dart';
import '../models/player_list.dart';
import '../models/vacation.dart';
import '../widgets/navigation_drawer.dart' as nav;

List<Player> players = getPlayers();
List<Player> filteredPlayers = List<Player>.from(players);

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

  Widget buildVacation(Vacation vacation) => ListTile(
        leading: Image.network(
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
                            deleteVacation(
                              id: vacation.id,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Eintrag wurde erfolgreich gelöscht.',
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const nav.NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Urlaub'),
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
                  hintText: 'Urlaubsliste durchsuchen...',
                ),
              ),
              const SizedBox(
                height: kBoxHeight,
              ),
              StreamBuilder<List<Vacation>>(
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
                    final vacations = snapshot.data!;

                    return Expanded(
                      child: ListView(
                        children: vacations.map(buildVacation).toList(),
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
                            child: const AddVacation(),
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
  // players accordingly
  void filterPlayers(String searchQuery) {
    if (searchQuery.isNotEmpty) {
      filteredPlayers = players
          .where((player) => player.name.contains(
                searchQuery,
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

class AddVacation extends StatefulWidget {
  const AddVacation({super.key});

  @override
  AddVacationState createState() => AddVacationState();
}

class AddVacationState extends State<AddVacation> {
  TextEditingController controllerStartDate = TextEditingController();
  TextEditingController controllerEndDate = TextEditingController();
  DateTime? pickedStartDate;
  DateTime? pickedEndDate;
  List<String> profilePictures = [];
  List<String> names = [];

  String dropdownValueName = players.first.name;

  @override
  void initState() {
    super.initState();
    for (var player in players) {
      profilePictures.add(player.profilePicture);
      names.add(player.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(
        0xff394E36,
      ),
      child: Container(
        padding: const EdgeInsets.all(
          kPadding,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              20.0,
            ),
            topRight: Radius.circular(
              20.0,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Urlaub hinzufügen',
              style: TextStyle(
                fontSize: kFontsizeSubtitle,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            DropdownButton<String>(
              value: dropdownValueName,
              elevation: kElevation.toInt(),
              items: names.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValueName = value!;
                });
              },
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            TextField(
              controller: controllerStartDate,
              autofocus: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
              ),
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.calendar_today,
                ),
                hintText: 'Startdatum auswählen',
              ),
              readOnly: true,
              onTap: () async {
                pickedStartDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(
                    DateTime.now().year,
                  ),
                  lastDate: DateTime(
                    DateTime.now().year + 1,
                  ),
                );

                if (pickedStartDate != null) {
                  String formattedDate =
                      DateFormat('dd.MM.yyyy').format(pickedStartDate!);

                  setState(() {
                    controllerStartDate.text = formattedDate;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Es wurde kein Datum ausgewählt.',
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            TextField(
              controller: controllerEndDate,
              //autofocus: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
              ),
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.calendar_today,
                ),
                hintText: 'Enddatum eingeben',
              ),
              readOnly: true,
              onTap: () async {
                pickedEndDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(
                    DateTime.now().year,
                  ),
                  lastDate: DateTime(
                    DateTime.now().year + 1,
                  ),
                );

                if (pickedEndDate != null) {
                  String formattedDate =
                      DateFormat('dd.MM.yyyy').format(pickedEndDate!);

                  setState(() {
                    controllerEndDate.text = formattedDate;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Es wurde kein Datum ausgewählt.',
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (pickedStartDate!.isAfter(pickedEndDate!)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Das Enddatum liegt for dem Startdatum.',
                      ),
                    ),
                  );
                  Navigator.pop(
                    context,
                  );
                } else {
                  createVacation(
                    startDate: controllerStartDate.text,
                    endDate: controllerEndDate.text,
                    name: dropdownValueName,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Eintrag wurde erfolgreich hinzugefügt.',
                      ),
                    ),
                  );
                  Navigator.pop(
                    context,
                  );
                }
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
                size: kIcon,
              ),
              label: const Text(
                'Hinzufügen',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateVacation extends StatefulWidget {
  const UpdateVacation(
      {super.key,
      required this.id,
      required this.startDate,
      required this.endDate,
      required this.name});

  final String id;
  final String startDate;
  final String endDate;
  final String name;

  @override
  UpdateVacationState createState() => UpdateVacationState();
}

class UpdateVacationState extends State<UpdateVacation> {
  TextEditingController controllerStartDate = TextEditingController();
  TextEditingController controllerEndDate = TextEditingController();
  DateTime? pickedStartDate;
  DateTime? pickedEndDate;
  List<String> profilePictures = [];
  List<String> names = [];

  String dropdownValueName = getPlayers().first.name;

  @override
  void initState() {
    super.initState();
    controllerStartDate.text = widget.startDate;
    controllerEndDate.text = widget.endDate;
    dropdownValueName = widget.name;
    for (var player in players) {
      profilePictures.add(player.profilePicture);
      names.add(player.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(
        0xff394E36,
      ),
      child: Container(
        padding: const EdgeInsets.all(
          kPadding,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              20.0,
            ),
            topRight: Radius.circular(
              20.0,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Urlaub aktualisieren',
              style: TextStyle(
                fontSize: kFontsizeSubtitle,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            DropdownButton<String>(
              value: widget.name,
              elevation: kElevation.toInt(),
              items: names.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValueName = value!;
                });
              },
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            TextField(
              controller: controllerStartDate,
              autofocus: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
              ),
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.calendar_today,
                ),
                hintText: 'Startdatum auswählen',
              ),
              readOnly: true,
              onTap: () async {
                pickedStartDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(
                    DateTime.now().year,
                  ),
                  lastDate: DateTime(
                    DateTime.now().year + 1,
                  ),
                );

                if (pickedStartDate != null) {
                  String formattedDate =
                      DateFormat('dd.MM.yyyy').format(pickedStartDate!);

                  setState(() {
                    controllerStartDate.text = formattedDate;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Es wurde kein Datum ausgewählt.',
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            TextField(
              controller: controllerEndDate,
              //autofocus: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
              ),
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.calendar_today,
                ),
                hintText: 'Enddatum auswählen',
              ),
              readOnly: true,
              onTap: () async {
                pickedEndDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(
                    DateTime.now().year,
                  ),
                  lastDate: DateTime(
                    DateTime.now().year + 1,
                  ),
                );

                if (pickedEndDate != null) {
                  String formattedDate =
                      DateFormat('dd.MM.yyyy').format(pickedEndDate!);

                  setState(() {
                    controllerEndDate.text = formattedDate;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Es wurde kein Datum ausgewählt.',
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (pickedStartDate!.isAfter(pickedEndDate!)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Das Enddatum liegt for dem Startdatum.',
                      ),
                    ),
                  );
                  Navigator.pop(
                    context,
                  );
                } else {
                  updateVacation(
                      id: widget.id,
                      startDate: controllerStartDate.text,
                      endDate: controllerEndDate.text,
                      name: dropdownValueName);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Eintrag wurde erfolgreich aktualisiert.',
                      ),
                    ),
                  );
                  Navigator.pop(
                    context,
                  );
                }
              },
              icon: const Icon(
                Icons.update,
                color: Colors.black,
                size: kIcon,
              ),
              label: const Text(
                'Aktualisieren',
              ),
            ),
          ],
        ),
      ),
    );
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
                  height: 20.0,
                  width: 150.0,
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

// Create penalty
Future createVacation(
    {required String startDate,
    required String endDate,
    required String name}) async {
  final docVacation = FirebaseFirestore.instance.collection('vacations').doc();

  final penalty = Vacation(
      id: docVacation.id, startDate: startDate, endDate: endDate, name: name);

  final json = penalty.toJson();

  await docVacation.set(json);
}

// Read all vacations
Stream<List<Vacation>> readVacations() => FirebaseFirestore.instance
    .collection('vacations')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Vacation.fromJson(doc.data())).toList());

// Update vacation
void updateVacation(
    {required String id,
    required String startDate,
    required String endDate,
    required String name}) {
  final vacation = FirebaseFirestore.instance.collection('vacations').doc(id);
  vacation.update({
    'startDate': startDate,
    'endDate': endDate,
    'name': name,
  });
}

// Delete vacation
void deleteVacation({required String id}) {
  final vacation = FirebaseFirestore.instance.collection('vacations').doc(id);
  vacation.delete();
}
