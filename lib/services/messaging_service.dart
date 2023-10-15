import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessagingService {
  @pragma('vm:entry-point')
  Future<void> messagingBackgroundHandler(RemoteMessage message) async {
    showFlutterNotification(message);
  }

  late AndroidNotificationChannel channel;

  bool isFlutterLocalNotificationsInitialized = false;

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'channel',
      'Notifications',
      description: 'This channel is used for notifications.',
      importance: Importance.defaultImportance,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launch_background',
          ),
        ),
      );
    }
  }

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  int messageCount = 0;

  String constructFCMPayload(String? token) {
    messageCount++;
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'Cloud Messaging',
        'count': messageCount.toString(),
      },
      'notification': {
        'title': 'Hello World!',
        'body': 'Notification dummy',
      },
    });
  }
}
