import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../classes/penalty.dart';
import '../classes/player_list.dart';
import '../constants/box_size.dart';
import '../constants/color.dart';
import '../constants/elevated_button.dart';
import '../constants/font_size.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';

bool isLoading = true;

class PenaltyScreen extends StatefulWidget {
  const PenaltyScreen({super.key});

  static const String id = 'penalty_screen';

  @override
  PenaltyScreenState createState() => PenaltyScreenState();
}

class PenaltyScreenState extends State<PenaltyScreen> {
  Widget buildUser(Penalty penalty) => ListTile(
        leading: Image.network(
          penalty.profilePicture,
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
          '${penalty.surname}, ${penalty.forename}',
        ),
        subtitle: Text(
          penalty.date,
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.more_vert,
          ),
          onPressed: () {},
        ),
      );

//toIso8601String()

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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

  // Create penalty
  Future createPenalty(
      {required String profilePicture,
      required String date,
      required String surname,
      required String forename,
      required String offense,
      required String amount,
      required String isPayed}) async {
    final docPenalty = FirebaseFirestore.instance.collection('penalties').doc();

    final penalty = Penalty(
        profilePicture: profilePicture,
        date: date,
        surname: surname,
        forename: forename,
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
}

class AddPenalty extends StatefulWidget {
  const AddPenalty({super.key});

  @override
  AddPenaltyState createState() => AddPenaltyState();
}

class AddPenaltyState extends State<AddPenalty> {
  TextEditingController dateInput = TextEditingController();

  String dropdownValueSurnames = getPlayers('surname').first;
  String dropdownValueForenames = getPlayers('forename').first;

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
              controller: dateInput,
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
                    dateInput.text = formattedDate;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
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
              value: dropdownValueSurnames,
              elevation: kElevation.toInt(),
              items: getPlayers('surname')
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValueSurnames = value!;
                });
              },
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            DropdownButton<String>(
              value: dropdownValueForenames,
              elevation: kElevation.toInt(),
              items: getPlayers('forename')
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValueForenames = value!;
                });
              },
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            TextField(
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
              ),
              onChanged: (value) {},
              decoration: const InputDecoration(
                hintText: 'Vergehen eingeben',
              ),
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            TextField(
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
              ),
              onChanged: (value) {},
              decoration: const InputDecoration(
                hintText: 'Betrag eingeben',
              ),
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            ElevatedButton.icon(
              onPressed: addPenalty,
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

  // Add penalty to list
  void addPenalty() {}
}

// Get desired list for the dropdown menu item
List<String> getPlayers(String attribute) {
  PlayerList playerList = PlayerList();
  List<String> list = [];

  switch (attribute) {
    case 'surname':
      for (var player in playerList.playerList) {
        list.add(player.surname);
      }
      break;

    case 'forename':
      for (var player in playerList.playerList) {
        list.add(player.forename);
      }
      break;
  }

  return list;
}
