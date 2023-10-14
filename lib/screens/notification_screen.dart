import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../constants/box_size.dart';
import '../constants/padding.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const route = '/notification-screen';

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Push-Benachrichtigung'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${message.notification?.title}',
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    '${message.notification?.body}',
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    '${message.data}',
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
