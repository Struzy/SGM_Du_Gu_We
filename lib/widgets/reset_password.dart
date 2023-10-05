import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/services/info_bar_service.dart';

import '../constants/box_size.dart';
import '../constants/font_size.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';
import '../services/authentication_service.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();
  late String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(
        0xff394E36,
      ),
      child: Container(
        padding: const EdgeInsets.all(
          kPadding,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              20.0,
            ),
            topRight: Radius.circular(
              20.0,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Passwort zurücksetzen',
              style: TextStyle(
                fontSize: kFontsizeSubtitle,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            TextField(
              controller: emailController,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) => email = value,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.mail,
                ),
                hintText: 'E-Mail eingeben',
              ),
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.black,
                size: kIcon,
              ),
              label: const Text(
                'Abbrechen',
              ),
            ),
            const SizedBox(
              height: kBoxHeight,
            ),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'E-Mail wurde versendet.',
                    ),
                  ),
                );
                AuthenticationService.resetPassword(
                  email: emailController.text,
                  context: context,
                );
                Navigator.pop(
                  context,
                );
              },
              icon: const Icon(
                Icons.mail,
                color: Colors.black,
                size: kIcon,
              ),
              label: const Text(
                'E-Mail senden',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
