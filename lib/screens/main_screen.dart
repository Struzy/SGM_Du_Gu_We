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

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String id = 'main_screen';

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  bool isLoading = true;

  static final year = DateTime.now().year;
  static final month = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
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
                        'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/App%20Icon%2Fsgm_du_gu_we.PNG?alt=media&token=b532fa33-870a-4e75-b3d9-2dbf0e7a43f0',
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            isLoading = false;
                            return child;
                          }
                          return const CircularProgressIndicator(
                            color: kSGMColorGreen,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: kBoxHeight + 40.0,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      LoginScreen.id,
                    );
                  },
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
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RegistrationScreen.id,
                    );
                  },
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
                          'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Logos%2FInstagram_logo_2022.svg.png?alt=media&token=4f08d604-3f98-4455-a0b2-3a12160053d0',
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              isLoading = false;
                              return child;
                            }
                            return const CircularProgressIndicator();
                          },
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
                          'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Logos%2FFacebook_Home_logo_old.svg.png?alt=media&token=3082cfd9-1614-4bd9-8637-463a5e6d7806',
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              isLoading = false;
                              return child;
                            }
                            return const CircularProgressIndicator();
                          },
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
}
