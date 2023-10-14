import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sgm_du_gu_we/main.dart';
import 'package:sgm_du_gu_we/screens/notification_screen.dart';

Future<void> messageBackgroundHandler(RemoteMessage message) async {
  /*print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');*/
}

class MessagingService {
  final messaging = FirebaseMessaging.instance;

  final androidChannel = const AndroidNotificationChannel(
    'channel',
    'Notifications',
    description: 'This channel is used for notifications',
    importance: Importance.defaultImportance,
  );
  final localNotifications = FlutterLocalNotificationsPlugin();

  void messageHandler(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      NotificationScreen.route,
      arguments: message,
    );
  }

  Future initPushNotifications() async {
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(messageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(messageHandler);
    FirebaseMessaging.onBackgroundMessage(messageBackgroundHandler);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidChannel.id,
              androidChannel.name,
              channelDescription: androidChannel.description,
              icon: '@drawable/ic_launcher-playstore',
            ),
          ),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future initLocalNotifications() async {
    const iOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {
      },
      icon: '@drawable/ic_launcher-playstore', // Provide the correct icon path
    );
    const android =
        AndroidInitializationSettings('@drawable/ic_launcher-playstore');
    const settings = InitializationSettings(android: android, iOS: iOS);

    await localNotifications.initialize(settings,
        onSelectNotification: (String? payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload!));
      messageHandler(message);
    });

    final platform = localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(androidChannel);
  }

  Future<void> initNotifications() async {
    await messaging.requestPermission();
    final fcmToken = await messaging.getToken();
    initPushNotifications();
    initLocalNotifications();
  }
}
