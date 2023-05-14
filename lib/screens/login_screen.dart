import 'package:flutter/material.dart';
import '../constants/box_size.dart';
import '../constants/circle_avatar.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';
import 'main_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const String id = 'login_screen';

  String email = '';
  String password = '';
  bool isLoading = false;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Anmeldung',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Hero(
                    tag: 'images/sgm_du_gu_we.PNG',
                    child: CircleAvatar(
                      radius: kRadius,
                      backgroundImage: AssetImage(
                        'images/sgm_du_gu_we.PNG',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight + 40.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      hintText: 'E-Mail eingeben',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.password,
                        color: Colors.black,
                      ),
                      hintText: 'Passwort eingeben',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  const SizedBox(
                    height: kBoxHeight + 20.0,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, MainScreen.id);
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
