import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/screens/notification_screen.dart';
import 'message.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<StatefulWidget> createState() => MessageListState();
}

class MessageListState extends State<MessageList> {
  List<RemoteMessage> messages = [];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        messages = [...messages, message];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const Text('Keine Push-Benachrichtigungen empfangen.');
    }

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          RemoteMessage message = messages[index];

          return ListTile(
            title: Text(
                message.messageId ?? 'no RemoteMessage.messageId available'),
            subtitle:
            Text(message.sentTime?.toString() ?? DateTime.now().toString()),
            onTap: () => Navigator.pushNamed(context, NotificationScreen.id,
                arguments: MessageArguments(message, false)),
          );
        });
  }
}