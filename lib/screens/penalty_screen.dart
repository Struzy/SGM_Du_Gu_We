import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgm_du_gu_we/models/offense.dart';
import '../models/amount.dart';
import '../models/penalty.dart';
import '../models/player_list.dart';
import '../constants/box_size.dart';
import '../constants/color.dart';
import '../constants/elevated_button.dart';
import '../constants/font_size.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';
import '../widgets/navigation_drawer.dart' as nav;

bool isLoading = true;

class PenaltyScreen extends StatefulWidget {
  const PenaltyScreen({super.key});

  static const String id = 'penalty_screen';

  @override
  PenaltyScreenState createState() => PenaltyScreenState();
}

class PenaltyScreenState extends State<PenaltyScreen> {
  Widget buildUser(Penalty penalty) => ListTile(
        title: Text(
          penalty.name,
        ),
        subtitle: Text(
          penalty.date,
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.more_vert,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                ),
              ),
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const nav.NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Offene Strafen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                    final penalties = snapshot.data!;

                    return Expanded(
                      child: ListView(
                        children: penalties.map(buildUser).toList(),
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
}

class AddPenalty extends StatefulWidget {
  const AddPenalty({super.key});

  @override
  AddPenaltyState createState() => AddPenaltyState();
}

class AddPenaltyState extends State<AddPenalty> {
  TextEditingController controllerDate = TextEditingController();

  String dropdownValueNames = getNames().first;
  String dropdownValueOffenses = getOffenses().first;
  String dropdownValueAmounts = getAmounts().first;

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
              'Strafe hinzufügen',
              style: TextStyle(
                fontSize: kFontsizeSubtitle,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            TextField(
              controller: controllerDate,
              autofocus: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
              ),
              onChanged: (value) {},
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                hintText: 'Datum eingeben',
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(
                    DateTime.now().year,
                  ),
                  lastDate: DateTime(
                    2100,
                  ),
                );

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('dd.MM.yyyy').format(pickedDate);

                  setState(() {
                    controllerDate.text = formattedDate;
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
            DropdownButton<String>(
              value: dropdownValueNames,
              elevation: kElevation.toInt(),
              items: getNames().map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValueNames = value!;
                });
              },
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            DropdownButton<String>(
              value: dropdownValueOffenses,
              elevation: kElevation.toInt(),
              items:
                  getOffenses().map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValueOffenses = value!;
                });
              },
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            DropdownButton<String>(
              value: dropdownValueAmounts,
              elevation: kElevation.toInt(),
              items: getAmounts().map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValueAmounts = value!;
                });
              },
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            ElevatedButton.icon(
              onPressed: () {
                createPenalty(
                  date: controllerDate.text,
                  name: dropdownValueNames,
                  offense: dropdownValueOffenses,
                  amount: dropdownValueAmounts,
                  isPayed: false,
                );
                Navigator.pop(context);
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

// Get players for the dropdown menu item
List<String> getNames() {
  PlayerList playerList = PlayerList();
  List<String> list = [];

  for (var player in playerList.playerList) {
    list.add(player.name);
  }

  return list;
}

// Get offenses for the dropdown menu item
List<String> getOffenses() {
  Offense offenses = Offense();
  List<String> list = [];

  for (var offense in offenses.offensesList) {
    list.add(offense);
  }

  return list;
}

// Get offenses for the dropdown menu item
List<String> getAmounts() {
  Amount amounts = Amount();
  List<String> list = [];

  for (var amount in amounts.amountsList) {
    list.add(amount);
  }

  return list;
}

// Create penalty
Future createPenalty(
    {required String date,
    required String name,
    required String offense,
    required String amount,
    required bool isPayed}) async {
  final docPenalty = FirebaseFirestore.instance.collection('penalties').doc();

  final penalty = Penalty(
      id: docPenalty.id,
      date: date,
      name: name,
      offense: offense,
      amount: amount,
      isPayed: isPayed);

  final json = penalty.toJson();

  await docPenalty.set(json);
}

// Read all penalties
Stream<List<Penalty>> readPenalties() => FirebaseFirestore.instance
    .collection('penalties')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Penalty.fromJson(doc.data())).toList());

// Update penalty
void updatePenalty() {
  final penalty = FirebaseFirestore.instance.collection('penalties').doc();
  penalty.update({
    'forename': 'Manuel',
  });
}

// Delete penalty
void deletePenalty() {
  final penalty = FirebaseFirestore.instance.collection('penalties').doc();
  penalty.delete();
}
