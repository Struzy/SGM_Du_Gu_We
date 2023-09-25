import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/screens/squad_screen.dart';
import '../constants/box_size.dart';
import '../constants/circle_avatar.dart';
import '../constants/color.dart';
import '../constants/font_family.dart';
import '../constants/icon_size.dart';
import '../constants/margin.dart';
import '../constants/padding.dart';
import '../constants/sgm_logo_directory.dart';
import '../models/Player.dart';
import '../services/authentication_service.dart';
import '../widgets/delete_profile.dart';
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
                        loggedInUser?.photoURL ?? kDefaultAvatarLogo,
                        fit: BoxFit.cover,
                        width: kRadius * 2,
                        height: kRadius * 2,
                        loadingBuilder: loadingBuilder,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: kVerticalMargin,
                      horizontal: kHorizontalMargin,
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      title: Text(
                        loggedInUser?.displayName ?? '',
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: kVerticalMargin,
                      horizontal: kHorizontalMargin,
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      title: Text(
                          loggedInUser?.email ?? '',
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
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
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
                      'Konto bearbeiten',
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: const DeleteProfile(),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Konto löschen',
                      style: TextStyle(
                        color: kSGMColorBlue,
                        fontFamily: kSpartanMB,
                      ),
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

  Widget loadingBuilder(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      isLoading = false;
      return child;
    }
    return const CircularProgressIndicator(
      color: kSGMColorGreen,
    );
  }
}
