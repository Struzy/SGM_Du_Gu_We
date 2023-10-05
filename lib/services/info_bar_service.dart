import 'package:flutter/material.dart';

class InfoBarService {
  static void showInfoBar(
      {required BuildContext context, required String info}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          info,
        ),
      ),
    );
  }
}
