import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sgm_du_gu_we/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/box_size.dart';
import '../constants/circle_avatar.dart';
import '../constants/color.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';
import '../services/authentication_service.dart';
import 'email_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String id = 'login_screen';

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscurePassword = true;
  late String email;
  late String password;
  bool isLoading = false;
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Anmeldung'),
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
                    Hero(
                      tag: 'logo',
                      child: CircleAvatar(
                        radius: kRadius * 1.2,
                        child: ClipOval(
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/App%20Icon%2Fsgm_du_gu_we.PNG?alt=media&token=b532fa33-870a-4e75-b3d9-2dbf0e7a43f0',
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
                      controller: emailController,
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
                      height: kBoxHeight + 20.0,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        saveData(email, password);
                        loginUser();
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
      ),
    );
  }

  // Save email and password from current login
  void saveData(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('saved_email', email);
    prefs.setString('saved_password', password);
  }

  // Load saved email and password from the last login
  void loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('saved_email');
    String? savedPassword = prefs.getString('saved_password');
    if (savedEmail != null && savedPassword != null) {
      setState(() {
        email = savedEmail;
        password = savedPassword;
        emailController.text = savedEmail;
        passwordController.text = savedPassword;
      });
    }
  }

  // Change password visibility depending on the user
  void togglePasswordVisibility() {
    setState(() {
      isObscurePassword = !isObscurePassword;
    });
  }

  // Register user as well as handle potentially occurring exceptions
  Future<void> loginUser() async {
    setState(() {
      isLoading = true;
      showSpinner = true;
    });
    final user = await AuthenticationService.signIn(
      userEmail: email,
      password: password,
      context: context,
    );
    if (user == null) {
      setState(() {
        isLoading = false;
        showSpinner = false;
      });
    } else if (user.emailVerified == false) {
      navigateToEMailVerificationScreen();
      setState(() {
        isLoading = false;
        showSpinner = false;
      });
      showSnackBar(
        'E-Mail wurde noch nicht verifiziert.',
      );
    } else if (user.emailVerified) {
      navigateToHomeScreen();
      setState(() {
        isLoading = false;
        showSpinner = false;
      });
      showSnackBar(
        'Erfolgreich angemeldet.',
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

  // Navigate to home screen
  void navigateToHomeScreen() {
    Navigator.pushNamed(
      context,
      HomeScreen.id,
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
