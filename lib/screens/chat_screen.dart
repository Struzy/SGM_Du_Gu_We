import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/color.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const String id = 'chat_screen';

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  late User loggedInUser;
  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: null,
            title: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Chat',
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
                onPressed: getMessagesStream,
                icon: const Icon(
                  Icons.close,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(
              kPadding,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  StreamBuilder<QuerySnapshot>(
                    stream: firestore.collection('messages').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        final messages = snapshot.data?.docs;
                        List<Text> messageWidgets = [];
                        for (var message in messages!) {
                          final messageText = message.get('text');
                          final messageSender = message.get('sender');

                          final messageWidget = Text(
                            '$messageText von $messageSender',
                          );
                          messageWidgets.add(messageWidget);
                        }
                        return Column(
                          children: messageWidgets,
                        );
                      }
                    },
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: kSGMColorGreen, width: 2.0),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              messageText = value;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              hintText: 'Nachricht',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            firestore.collection('messages').add({
                              'text': messageText,
                              'sender': loggedInUser.email,
                            });
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.black,
                            size: kIcon,
                          ),
                          label: const Text(
                            'Senden',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  // Get current user
  void getCurrentUser() async {
    try {
      final user = await auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Es ist zurzeit kein Anwender angemeldet.',
          ),
        ),
      );
    }
  }

  // Listen to Cloud Firestore and get messages instantly
  void getMessagesStream() async {
    await for (var snapshot in firestore.collection('messages').snapshots()) {
      snapshot.docs;
    }
  }
}
