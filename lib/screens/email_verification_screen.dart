import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/box_size.dart';
import '../constants/color.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';
import '../constants/timer.dart';
import '../services/authentication_service.dart';
import 'main_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static const String id = 'email_verification_screen';

  @override
  State<EmailVerificationScreen> createState() =>
      EmailVerificationScreenState();
}

class EmailVerificationScreenState extends State<EmailVerificationScreen> {
  Timer? timer;
  final auth = FirebaseAuth.instance;
  bool isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    try {
      auth.currentUser?.sendEmailVerification();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
    timer = Timer.periodic(
      const Duration(
        seconds: kTimerEmailVerification,
      ),
      (_) => checkEmailVerified(),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Email-Verifikation'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Überprüfen Sie Ihr Email-Postfach',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Eine Email wurde an ${auth.currentUser?.email} gesendet',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: kBoxHeight + 20.0,
                ),
                const CircularProgressIndicator(
                  backgroundColor: kSGMColorGreenLight,
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: kBoxHeight,
                ),
                const Text(
                  'Email verifizieren...',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: kBoxHeight + 20.0,
                ),
                ElevatedButton.icon(
                  onPressed: resendEmail,
                  icon: const Icon(
                    Icons.email,
                    color: Colors.black,
                    size: kIcon,
                  ),
                  label: const Text(
                    'Erneut senden',
                  ),
                ),
                TextButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50.0),
                  ),
                  child: const Text(
                    'Abbrechen',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  onPressed: () {
                    AuthenticationService.signOut(context: context);
                    Navigator.pushNamed(
                      context,
                      MainScreen.id,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Check whether email is verified
  checkEmailVerified() async {
    await auth.currentUser?.reload();
    setState(() {
      isEmailVerified = auth.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Email erfolgreich verifiziert.',
          ),
        ),
      );
      timer?.cancel();
      Navigator.pushNamed(
        context,
        MainScreen.id,
      );
    }
  }

  // Resend email
  Future<void> resendEmail() async {
    try {
      auth.currentUser?.sendEmailVerification();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }
}
