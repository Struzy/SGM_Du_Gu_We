import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sgm_du_gu_we/constants/color.dart';
import '../constants/box_size.dart';
import '../constants/circle_avatar.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';
import '../services/authentication_service.dart';
import 'email_verification_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static const String id = 'registration_screen';

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool isLoading = false;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Registrierung',
          ),
        ),
        body: ModalProgressHUD(
          color: kSGMColorGreen,
          inAsyncCall: showSpinner,
          child: Padding(
            padding: const EdgeInsets.all(
              kPadding,
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Hero(
                      tag: 'logo',
                      child: CircleAvatar(
                        radius: kRadius * 1.2,
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
                    TextField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      onChanged: (value) {
                        confirmPassword = value;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.repeat,
                          color: Colors.black,
                        ),
                        hintText: 'Passwort bestätigen',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: kBoxHeight + 20.0,
                    ),
                    ElevatedButton.icon(
                      onPressed: registerUser,
                      icon: const Icon(
                        Icons.app_registration,
                        color: Colors.black,
                        size: kIcon,
                      ),
                      label: const Text(
                        'Registrieren',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Register user as well as handle potentially occurring exceptions
  Future<void> registerUser() async {
    {
      if (password == confirmPassword) {
        setState(() {
          isLoading = true;
          showSpinner = true;
        });
        await AuthenticationService.signUp(
            userEmail: email,
            password: password,
            context: context
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Given passwords do not correspond',
            ),
          ),
        );
      }
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushNamed(
          context,
          EmailVerificationScreen.id,
        );
      }
      setState(() {
        isLoading = false;
        showSpinner = false;
      });
    }
  }
}
