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
import '../models/vacation.dart';

class AddVacation extends StatefulWidget {
  const AddVacation({super.key, required this.playerData});

  final List<Player> playerData;

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
  String dropdownValueName = '';

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
                  try {
                    createVacation(
                      startDate: controllerStartDate.text,
                      endDate: controllerEndDate.text,
                      name: dropdownValueName,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Urlaub konnte nicht hinzugefügt werden.',
                        ),
                      ),
                    );
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Urlaub wurde erfolgreich hinzugefügt.',
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

// Create vacation
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
