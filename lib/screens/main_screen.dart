import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/color.dart';
import 'package:sgm_du_gu_we/screens/login_screen.dart';
import 'package:sgm_du_gu_we/screens/registration_screen.dart';
import '../constants/box_size.dart';
import '../constants/circle_avatar.dart';
import '../constants/container_size.dart';
import '../constants/divider_thickness.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';
import '../constants/sgm_logo_directory.dart';
import '../constants/social_network_logo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String id = 'main_screen';

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  bool isLoading = true;

  static final year = DateTime
      .now()
      .year;
  static final month = DateTime
      .now()
      .month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: CircleAvatar(
                    radius: kRadius,
                    child: ClipOval(
                      child: Image.network(
                        kSGMLogo,
                        fit: BoxFit.cover,
                        loadingBuilder: loadingBuilder,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: kBoxHeight + 40.0,
                ),
                ElevatedButton.icon(
                  onPressed: navigateToLoginScreen,
                  icon: const Icon(
                    Icons.login,
                    color: Colors.black,
                    size: kIcon,
                  ),
                  label: const Text(
                    'Anmelden',
                  ),
                ),
                const SizedBox(
                  height: kBoxHeight,
                ),
                const Text(
                  'Noch kein Nutzer? Jetzt registrieren!',
                ),
                const SizedBox(
                  height: kBoxHeight,
                ),
                ElevatedButton.icon(
                  onPressed: navigateToRegistrationScreen,
                  icon: const Icon(
                    Icons.app_registration,
                    color: Colors.black,
                    size: kIcon,
                  ),
                  label: const Text(
                    'Registrieren',
                  ),
                ),
                const SizedBox(
                  height: kBoxHeight,
                ),
                const Text(
                  'Besuchen Sie uns auch auf',
                ),
                const SizedBox(
                  height: kBoxHeight,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      height: kContainerHeight,
                      width: kContainerWidth,
                      child: ClipOval(
                        child: Image.network(
                          kInstagramIcon,
                          fit: BoxFit.cover,
                          loadingBuilder: loadingBuilder,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: kBoxWidth,
                    ),
                    Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      height: kContainerHeight,
                      width: kContainerWidth,
                      child: ClipOval(
                        child: Image.network(
                          kFacebookLogo,
                          fit: BoxFit.cover,
                          loadingBuilder: loadingBuilder,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: kBoxHeight,
                ),
                const Divider(
                  thickness: kDividerThickness,
                  color: Colors.black54,
                ),
                const SizedBox(
                  height: kBoxHeight,
                ),
                Text(
                  'Copyright © $month/$year',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const Text(
                  'SGM Durchhausen/Gunningen/Weigheim',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const Text(
                  'All Rights Reserved.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Navigate to registration screen
  void navigateToRegistrationScreen() {
    Navigator.pushNamed(
      context,
      RegistrationScreen.id,
    );
  }

  // Navigate to login screen
  void navigateToLoginScreen() {
    Navigator.pushNamed(
      context,
      LoginScreen.id,
    );
  }

  // Loading builder
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
