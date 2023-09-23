import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/box_decoration.dart';
import 'package:sgm_du_gu_we/models/user_profile.dart';
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
  late String name;
  List<Player> players = [];

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
              'Profil bearbeiten',
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
                hintText: 'Vollständigen Namen eingeben',
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
                try {
                  createUserProfile(
                    profilePicture: getPath(controllerName.text),
                    userName: controllerName.text,
                    userEmail: loggedInUser!.email!,
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Profil konnte nicht erstellt werden.',
                      ),
                    ),
                  );
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Profil wurde erfolgreich hinzugefügt.',
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
                'Erstellen',
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
}

// Create vacation
Future createUserProfile(
    {required profilePicture,
    required String userName,
    required String userEmail}) async {
  final docUserProfile =
      FirebaseFirestore.instance.collection('userProfiles').doc();
  final userProfile = UserProfile(
      id: docUserProfile.id,
      profilePicture: profilePicture,
      name: userName,
      email: userEmail);
  final json = userProfile.toJson();
  await docUserProfile.set(json);
}
