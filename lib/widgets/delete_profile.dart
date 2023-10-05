import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/services/info_bar_service.dart';

import '../constants/box_decoration.dart';
import '../constants/box_size.dart';
import '../constants/font_size.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';
import '../screens/main_screen.dart';
import '../services/authentication_service.dart';

class DeleteProfile extends StatefulWidget {
  const DeleteProfile({super.key});

  @override
  DeleteProfileState createState() => DeleteProfileState();
}

class DeleteProfileState extends State<DeleteProfile> {
  late User? loggedInUser;
  TextEditingController controllerEmail = TextEditingController();
  late String email;

  @override
  void initState() {
    super.initState();
    loggedInUser = AuthenticationService.getUser(context);
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
              'Benutzerkonto löschen',
              style: TextStyle(
                fontSize: kFontsizeSubtitle,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            TextField(
              controller: controllerEmail,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) => email = value,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.email,
                ),
                hintText: 'E-Mail eingeben',
              ),
            ),
            const SizedBox(
              height: kBoxHeight,
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
                if (email == loggedInUser?.email) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'Benutzerkonto löschen',
                      ),
                      content: const Text(
                        'Wollen Sie das Benutzerkonto wirklich löschen?',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                              'JA',
                            );
                            try {
                              AuthenticationService.deleteUser(
                                user: loggedInUser,
                                context: context,
                              );
                              Navigator.pushNamed(
                                context,
                                MainScreen.id,
                              );
                              InfoBarService.showInfoBar(
                                context: context,
                                info: 'Benutzerkonto erfolgreich gelöscht.',
                              );
                            } catch (e) {
                              InfoBarService.showInfoBar(
                                context: context,
                                info:
                                    'Das Benutzerkonto konnte nicht gelöscht werden.',
                              );
                            }
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
                }
              },
              icon: const Icon(
                Icons.update,
                color: Colors.black,
                size: kIcon,
              ),
              label: const Text(
                'Benutzerkonto löschen',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
