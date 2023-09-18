import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/box_size.dart';
import '../constants/elevated_button.dart';
import '../constants/font_size.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';
import '../screens/penalty_screen.dart';
import '../services/database_update_service.dart';

class UpdatePenalty extends StatefulWidget {
  const UpdatePenalty(
      {super.key,
      required this.id,
      required this.date,
      required this.name,
      required this.offense,
      required this.amount});

  final String id;
  final String date;
  final String name;
  final String offense;
  final String amount;

  @override
  UpdatePenaltyState createState() => UpdatePenaltyState();
}

class UpdatePenaltyState extends State<UpdatePenalty> {
  TextEditingController controllerDate = TextEditingController();
  DateTime? pickedDate;
  List<String> profilePictures = [];
  List<String> names = [];

  String dropdownValueName = players.first.name;
  String dropdownValueOffense = getOffenses().first;
  String dropdownValueAmount = getAmounts().first;

  @override
  void initState() {
    super.initState();
    controllerDate.text = widget.date;
    dropdownValueName = widget.name;
    dropdownValueOffense = widget.offense;
    dropdownValueAmount = widget.amount;
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
              'Strafe aktualisieren',
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
                items: getOffenses().map<DropdownMenuItem<String>>((String value) {
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
                  DatabaseUpdateService.updatePenalty(
                      id: widget.id,
                      date: widget.date,
                      name: widget.name,
                      offense: widget.offense,
                      amount: widget.amount);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Strafe konnte nicht aktualisiert werden.',
                      ),
                    ),
                  );
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Strafe wurde erfolgreich aktualisiert.',
                    ),
                  ),
                );
                Navigator.pop(
                  context,
                );
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
