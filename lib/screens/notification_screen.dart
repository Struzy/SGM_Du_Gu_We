import 'package:sgm_du_gu_we/models/permissions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/services/info_bar_service.dart';
import '../constants/padding.dart';
import '../models/message.dart';
import '../models/message_list.dart';
import '../models/token_monitor.dart';
import 'package:http/http.dart' as http;
import '../services/messaging_service.dart';
import '../widgets/meta_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static const String id = 'notification_screen';

  @override
  State<NotificationScreen> createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  String? token;
  String? initialMessage;
  bool resolved = false;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then(
          (value) => setState(
            () {
              resolved = true;
              initialMessage = value?.data.toString();
            },
          ),
        );

    FirebaseMessaging.onMessage
        .listen(MessagingService().showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.pushNamed(
        context,
        NotificationScreen.id,
        arguments: MessageArguments(message, true),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push-Benachrichtigung'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: onActionSelected,
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'Abonnieren',
                  child: Text(
                    'Thema abonnieren',
                  ),
                ),
                const PopupMenuItem(
                  value: 'Abbestellen',
                  child: Text(
                    'Thema abbestellen',
                  ),
                ),
                const PopupMenuItem(
                  value: 'get_apns_token',
                  child: Text(
                    'APNs-Token abrufen (nur Apple)',
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: sendPushMessage,
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.send,
          ),
        ),
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
                children: [
                  const MetaCard('Permissions', Permissions()),
                  MetaCard(
                    'Initial Message',
                    Column(
                      children: [
                        Text(resolved ? 'Resolved' : 'Resolving'),
                        Text(initialMessage ?? 'None'),
                      ],
                    ),
                  ),
                  MetaCard(
                    'FCM Token',
                    TokenMonitor((token) {
                      token = token;
                      return token == null
                          ? const CircularProgressIndicator()
                          : SelectableText(
                              token,
                              style: const TextStyle(fontSize: 12),
                            );
                    }),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseMessaging.instance.getInitialMessage().then(
                        (RemoteMessage? message) {
                          if (message != null) {
                            Navigator.pushNamed(
                              context,
                              NotificationScreen.id,
                              arguments: MessageArguments(message, true),
                            );
                          }
                        },
                      );
                    },
                    child: const Text('getInitialMessage()'),
                  ),
                  const MetaCard('Message Stream', MessageList()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendPushMessage() async {
    if (token == null) {
      InfoBarService.showInfoBar(
        context: context,
        info:
            'Die Push-Benachrichtigung kann nicht gesendet werden, da kein Token vorhanden ist.',
      );
      return;
    }

    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: MessagingService().constructFCMPayload(token),
      );
      InfoBarService.showInfoBar(
        context: context,
        info: 'Anfrage für Push-Benachrichtigung des Gerätes gesendet.',
      );
    } catch (e) {
      InfoBarService.showInfoBar(
        context: context,
        info: 'Push-Benachrichtigung konnte nicht gesendet werden.',
      );
    }
  }

  Future<void> onActionSelected(String value) async {
    switch (value) {
      case 'subscribe':
        {
          await FirebaseMessaging.instance.subscribeToTopic('SGM Du/Gu/We');
          InfoBarService.showInfoBar(
            context: context,
            info: 'Das Abonnieren des Themas „SGM Du/Gu/We“ war erfolgreich.',
          );
        }
        break;
      case 'unsubscribe':
        {
          await FirebaseMessaging.instance.unsubscribeFromTopic('SGM Du/Gu/We');
          InfoBarService.showInfoBar(
            context: context,
            info: 'Das Abbestellen des Themas „SGM Du/Gu/We“ war erfolgreich.',
          );
        }
        break;
      case 'get_apns_token':
        {
          if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.macOS) {
            String? token = await FirebaseMessaging.instance.getAPNSToken();
          } else {
            InfoBarService.showInfoBar(
              context: context,
              info:
                  'Der Erhalt eines APNs-Tokens wird nur auf iOS- und macOS-Plattformen unterstützt.',
            );
          }
        }
        break;
      default:
        break;
    }
  }
}
