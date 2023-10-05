import 'package:flutter/material.dart';

class NavigationService {
  static void navigateTo(
      {required BuildContext context, required String screenId}) {
    Navigator.pushNamed(
      context,
      screenId,
    );
  }
}
