import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/box_size.dart';
import '../constants/elevated_button.dart';
import '../constants/font_size.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';
import '../screens/vacation_screen.dart';
import '../services/database_update_service.dart';

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
                    updateVacation(
                        id: widget.id,
                        startDate: controllerStartDate.text,
                        endDate: controllerEndDate.text,
                        name: dropdownValueName);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Urlaub konnte nicht aktualisiert werden.',
                        ),
                      ),
                    );
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Urlaub wurde erfolgreich aktualisiert.',
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