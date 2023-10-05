import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/sgm_logo_directory.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sgm_du_gu_we/constants/color.dart';
import 'package:sgm_du_gu_we/services/info_bar_service.dart';
import 'package:sgm_du_gu_we/services/navigation_service.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants/box_size.dart';
import '../constants/circle_avatar.dart';
import '../constants/font_family.dart';
import '../constants/font_size.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';
import '../constants/privacy_policy_directory.dart';
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
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'Ich willige in die Datenverarbeitung gemäß der\n',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextSpan(
                                text: 'Datenschutzerklärung',
                                style: const TextStyle(
                                  color: kSGMColorBlue,
                                  fontFamily: kSourceSansPro,
                                  fontSize: kFontsizeBody,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PrivacyPolicy(),
                                      ),
                                    );
                                  },
                              ),
                              TextSpan(
                                text: ' ein.',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
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
            NavigationService.navigateTo(
              context: context,
              screenId: EmailVerificationScreen.id,
            );
          }
          if (newUser == null) {
            setState(() {
              isLoading = false;
              showSpinner = false;
            });
          }
        } else {
          InfoBarService.showInfoBar(
            context: context,
            info: 'Es wurde der Datenschutzerklärung nicht zugestimmt.',
          );
        }
      } else {
        InfoBarService.showInfoBar(
          context: context,
          info: 'Passwörter stimmen nicht überein.',
        );
      }
    }
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
}

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  PrivacyPolicyState createState() => PrivacyPolicyState();
}

class PrivacyPolicyState extends State<PrivacyPolicy> {
  int progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Datenschutzerklärung',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            Expanded(
              child: WebView(
                initialUrl: kPrivacyPolicy,
                javascriptMode: JavascriptMode.unrestricted,
                onProgress: (int newProgress) {
                  setState(() {
                    progress = newProgress;
                  });
                },
                onPageFinished: (String url) {
                  setState(() {
                    progress = 0;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
