import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/box_decoration.dart';
import '../constants/box_size.dart';
import '../constants/elevated_button.dart';
import '../constants/font_size.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';
import '../models/Player.dart';
import '../models/penalty.dart';
import '../screens/penalty_screen.dart';

class AddPenalty extends StatefulWidget {
  const AddPenalty({super.key, required this.playerData});

  final List<Player> playerData;

  @override
  AddPenaltyState createState() => AddPenaltyState();
}

class AddPenaltyState extends State<AddPenalty> {
  TextEditingController controllerDate = TextEditingController();
  DateTime? pickedDate;
  List<String> profilePictures = [];
  List<String> names = [];

  String dropdownValueName = '';
  String dropdownValueOffense = getOffenses().first;
  String dropdownValueAmount = getAmounts().first;

  @override
  void initState() {
    super.initState();
    dropdownValueName = widget.playerData.first.name;
    for (var player in widget.playerData) {
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
              kBorderRadiusContainer,
            ),
            topRight: Radius.circular(
              kBorderRadiusContainer,
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
              controller: controllerDate,
              autofocus: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
              ),
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.calendar_today,
                ),
                hintText: 'Datum auswählen',
              ),
              readOnly: true,
              onTap: () async {
                pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(
                    DateTime.now().year,
                  ),
                  lastDate: DateTime(
                    DateTime.now().year + 1,
                  ),
                );

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('dd.MM.yyyy').format(pickedDate!);

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
            FittedBox(
              fit: BoxFit.scaleDown,
              child: DropdownButton<String>(
                value: dropdownValueOffense,
                elevation: kElevation.toInt(),
                items:
                    getOffenses().map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValueOffense = value!;
                  });
                },
              ),
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            DropdownButton<String>(
              value: dropdownValueAmount,
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
                  dropdownValueAmount = value!;
                });
              },
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.black,
                size: kIcon,
              ),
              label: const Text(
                'Abbrechen',
              ),
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            ElevatedButton.icon(
              onPressed: () {
                try {
                  createPenalty(
                      date: controllerDate.text,
                      name: dropdownValueName,
                      offense: dropdownValueOffense,
                      amount: dropdownValueAmount);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Strafe konnte nicht hinzugefügt werden.',
                      ),
                    ),
                  );
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Strafe wurde erfolgreich hinzugefügt.',
                    ),
                  ),
                );
                Navigator.pop(
                  context,
                );
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

// Create penalty
Future createPenalty(
    {required String date,
    required String name,
    required String offense,
    required String amount}) async {
  final docPenalty = FirebaseFirestore.instance.collection('penalties').doc();
  final penalty = Penalty(
      id: docPenalty.id,
      date: date,
      name: name,
      offense: offense,
      amount: amount);
  final json = penalty.toJson();
  await docPenalty.set(json);
}
