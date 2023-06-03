import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/color.dart';
import '../constants/box_size.dart';
import '../constants/elevated_button.dart';
import '../constants/padding.dart';

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
            title: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Chat',
                ),
              ],
            ),
            actions: <Widget>[],
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
                  const MessagesStream(),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.black54,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
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
                              'text': messageText,
                              'sender': loggedInUser.email,
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

class MessagesStream extends StatelessWidget {
  const MessagesStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final messages = snapshot.data?.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages!) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');

            final currentUser = auth.currentUser?.email;

            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: messageBubbles,
            ),
          );
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.sender,
      required this.text,
      required this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        10.0,
      ),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(
                      30.0,
                    ),
                    bottomLeft: Radius.circular(
                      30.0,
                    ),
                    bottomRight: Radius.circular(
                      30.0,
                    ),
                  )
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(
                      30.0,
                    ),
                    bottomRight: Radius.circular(
                      30.0,
                    ),
                    topRight: Radius.circular(
                      30.0,
                    ),
                  ),
            elevation: 5.0,
            color: isMe ? kSGMColorBlue : kSGMColorRed,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
