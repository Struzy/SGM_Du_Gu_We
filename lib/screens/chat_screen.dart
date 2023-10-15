import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/color.dart';
import 'package:sgm_du_gu_we/constants/divider_thickness.dart';
import 'package:sgm_du_gu_we/services/authentication_service.dart';
import '../constants/box_size.dart';
import '../constants/elevated_button.dart';
import '../constants/padding.dart';
import '../widgets/messages_stream.dart';

final firestore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const String id = 'chat_screen';

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  late User? loggedInUser;
  late String messageText;
  late String timeStamp;

  @override
  void initState() {
    super.initState();
    loggedInUser = AuthenticationService.getUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Chat',
            ),
          ],
        ),
        actions: const <Widget>[],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const MessagesStream(),
                Container(
                  padding: const EdgeInsets.only(
                    top: kPadding - 15.0,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black54,
                        width: kDividerThickness,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          autocorrect: true,
                          maxLines: null,
                          style: const TextStyle(
                            color: Colors.black54,
                          ),
                          controller: messageTextController,
                          onChanged: (value) {
                            messageText = value;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Nachricht',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: kBoxWidth,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          messageTextController.clear();
                          firestore.collection('messages').add({
                            'timeStamp': getTimeStamp(),
                            'text': messageText,
                            'sender': loggedInUser?.email,
                          });
                        },
                        foregroundColor: Colors.black,
                        backgroundColor: kSGMColorGreen,
                        elevation: kElevation,
                        child: const Icon(
                          Icons.send,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Get current formatted time stamp
String getTimeStamp() {
  DateTime now = DateTime.timestamp();

  // Format the date
  String day = now.day.toString().padLeft(2, '0');
  String month = now.month.toString().padLeft(2, '0');
  String year = now.year.toString();

  // Format the time in 24-hour clock format
  String hour = now.hour.toString().padLeft(2, '0');
  String minute = now.minute.toString().padLeft(2, '0');

  return "$day.$month.$year, $hour:$minute";
}
