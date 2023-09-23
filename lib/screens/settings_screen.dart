import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/box_size.dart';
import '../constants/circle_avatar.dart';
import '../constants/color.dart';
import '../constants/icon_size.dart';
import '../constants/margin.dart';
import '../constants/padding.dart';
import '../constants/sgm_logo_directory.dart';
import '../models/Player.dart';
import '../services/authentication_service.dart';
import '../widgets/edit_profile.dart';
import 'main_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const String id = 'settings_screen';

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  late User? loggedInUser;
  bool isLoading = true;
  List<Player> players = [];

  @override
  void initState() {
    super.initState();
    loggedInUser = AuthenticationService.getUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Einstellungen',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: kRadius,
                    child: ClipOval(
                      child: Image.network(
                          kSGMLogo,
                          fit: BoxFit.cover,
                          loadingBuilder: loadingBuilder,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  const Card(
                    margin: EdgeInsets.symmetric(
                      vertical: kVerticalMargin,
                      horizontal: kHorizontalMargin,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      title: Text(
                        '',
                      ),
                    ),
                  ),
                  const Card(
                    margin: EdgeInsets.symmetric(
                      vertical: kVerticalMargin,
                      horizontal: kHorizontalMargin,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      title: Text(
                        '',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) =>
                            SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                  bottom:
                                  MediaQuery
                                      .of(context)
                                      .viewInsets
                                      .bottom,
                                ),
                                child: const EditProfile(),
                              ),
                            ),
                      );
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.black,
                      size: kIcon,
                    ),
                    label: const Text(
                      'Profil bearbeiten',
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(
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
                                    AuthenticationService.deleteUser(
                                      user: loggedInUser,
                                      context: context,
                                    );
                                    Navigator.pushNamed(
                                      context,
                                      MainScreen.id,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Benutzerkonto erfolgreich gelöscht.',
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
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.black,
                      size: kIcon,
                    ),
                    label: const Text(
                      'Konto löschen',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loadingBuilder(BuildContext context, Widget child,
      ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      isLoading = false;
      return child;
    }
    return const CircularProgressIndicator(
      color: kSGMColorGreen,
    );
  }
}
