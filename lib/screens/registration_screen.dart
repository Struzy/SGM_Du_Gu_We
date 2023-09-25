import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/sgm_logo_directory.dart';
import 'package:url_launcher/url_launcher.dart';
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
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isObscurePassword = true;
  bool isObscureConfirmPassword = true;
  final auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String confirmPassword;
  bool isLoading = false;
  bool showSpinner = false;
  bool isChecked = false;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registrierung',
        ),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
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
                    Hero(
                      tag: 'logo',
                      child: CircleAvatar(
                        radius: kRadius * 1.25,
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
                    TextField(
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
                    TextField(
                      controller: passwordController,
                      obscureText: isObscurePassword,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      onChanged: (value) => password = value,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.password,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: togglePasswordVisibility,
                        ),
                        hintText: 'Passwort eingeben',
                      ),
                    ),
                    const SizedBox(
                      height: kBoxHeight,
                    ),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: isObscureConfirmPassword,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      onChanged: (value) => confirmPassword = value,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.repeat,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscureConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: toggleConfirmPasswordVisibility,
                        ),
                        hintText: 'Passwort bestätigen',
                      ),
                    ),
                    const SizedBox(
                      height: kBoxHeight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(
                          activeColor: kSGMColorRed,
                          value: isChecked,
                          onChanged: (bool? newValue) {
                            setState(() {
                              isChecked = newValue!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: kBoxWidth,
                        ),
                        const Text(
                          'Ich willige in die Datenverarbeitung gemäß der\nDatenschutzerklärung ein.',
                        ),
                      ],
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

  // Change password visibility depending on the user
  void togglePasswordVisibility() {
    setState(() {
      isObscurePassword = !isObscurePassword;
    });
  }

  // Change password visibility depending on the user
  void toggleConfirmPasswordVisibility() {
    setState(() {
      isObscureConfirmPassword = !isObscureConfirmPassword;
    });
  }

  // Register user as well as handle potentially occurring exceptions
  Future<void> registerUser() async {
    {
      if (password == confirmPassword) {
        if (isChecked == true) {
          setState(() {
            isLoading = true;
            showSpinner = true;
          });
          final newUser = await AuthenticationService.signUp(
            userEmail: email,
            password: password,
            context: context,
          );
          if (FirebaseAuth.instance.currentUser != null) {
            Navigator.pushNamed(
              context,
              EmailVerificationScreen.id,
            );
          }
          if (newUser == null) {
            setState(() {
              isLoading = false;
              showSpinner = false;
            });
          }
        } else {
          showSnackBar(
            'Es wurde der Datenschutzerklärung nicht zugestimmt.',
          );
        }
      } else {
        showSnackBar(
          'Passwörter stimmen nicht überein.',
        );
      }
    }
  }

  // Launch url to privacy policy
  void launchURL() async {
    const url = 'http://www.sv-durchhausen.de/datenschutzerklaerung/';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      showSnackBar(
        'Die Datenschutzerklärung konnte nicht geöffnet werden.',
      );
    }
  }

  // Navigate to email verification screen
  void navigateToEMailVerificationScreen() {
    Navigator.pushNamed(
      context,
      EmailVerificationScreen.id,
    );
  }

  // Loading builder
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

  // Show snack bar
  void showSnackBar(String snackBarText) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          snackBarText,
        ),
      ),
    );
  }
}
