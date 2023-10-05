import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/box_decoration.dart';
import 'package:sgm_du_gu_we/screens/home_screen.dart';
import 'package:sgm_du_gu_we/services/info_bar_service.dart';
import '../constants/box_size.dart';
import '../constants/font_size.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';
import '../models/Player.dart';
import '../screens/squad_screen.dart';
import '../services/authentication_service.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  late User? loggedInUser;
  TextEditingController controllerName = TextEditingController();
  List<Player> players = [];
  late String name;
  late String profilePicture;

  @override
  void initState() {
    super.initState();
    loggedInUser = AuthenticationService.getUser(context);
    readPlayers().listen((List<Player> playerData) {
      players = playerData;
    });
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
              'Benutzerkonto bearbeiten',
              style: TextStyle(
                fontSize: kFontsizeSubtitle,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            TextField(
              controller: controllerName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) => name = value,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.person,
                ),
                hintText: 'Vor- und Nachnamen eingeben',
              ),
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
              onPressed: () async {
                for (final player in players) {
                  if (player.name == loggedInUser?.displayName) {
                    profilePicture = player.profilePicture;
                    break;
                  }
                }
                try {
                  await loggedInUser!.updateDisplayName(name);
                  await loggedInUser!.updatePhotoURL(profilePicture);
                  await loggedInUser?.reload();
                  InfoBarService.showInfoBar(
                    context: context,
                    info: 'Benutzerkonto wurde erfolgreich aktualisiert.',
                  );
                  Navigator.pushNamed(
                    context,
                    HomeScreen.id,
                  );
                } catch (e) {
                  InfoBarService.showInfoBar(
                    context: context,
                    info: 'Benutzerkonto konnte nicht aktualisiert werden.',
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
                'Konto aktualisieren',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
