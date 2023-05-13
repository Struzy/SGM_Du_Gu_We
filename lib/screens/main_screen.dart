import 'package:flutter/material.dart';
import '../constants/padding.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const String id = 'main_screen';

  static final year = DateTime.now().year;
  static final month = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          kPadding,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const CircleAvatar(
                  radius: 100.0,
                  backgroundImage: AssetImage(
                    'images/sgm_du_gu_we.PNG',
                  ),
                ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, MainScreen.id);
                    },
                    icon: const Icon(
                      Icons.login,
                      color: Colors.black,
                      size: 24.0,
                    ),
                    label: const Text(
                      'Anmelden',
                    ),
                  ),
                ),
                const Text(
                  'Noch kein Nutzer? Jetzt registrieren!',
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, MainScreen.id);
                  },
                  icon: const Icon(
                    Icons.app_registration,
                    color: Colors.black,
                    size: 24.0,
                  ),
                  label: const Text(
                    'Registrieren',
                  ),
                ),
                const Text(
                  'Besuchen Sie uns auch auf',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      height: 30.0,
                      width: 30.0,
                      child: const Image(
                        image: NetworkImage(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Instagram_logo_2022.svg/1024px-Instagram_logo_2022.svg.png',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: Image(
                        image: NetworkImage(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Facebook_Home_logo_old.svg/1024px-Facebook_Home_logo_old.svg.png',
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black54,
                ),
                Text(
                  'Copyright © ${year}/${month}',
                ),
                const Text(
                  'SGM Durchhausen/Gunningen/Weigheim',
                ),
                const Text(
                  'All Rights Reserved.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
