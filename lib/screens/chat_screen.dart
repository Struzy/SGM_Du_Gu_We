import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/color.dart';
import '../constants/chat.dart';
import '../constants/icon_size.dart';
import '../constants/padding.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const String id = 'chat_screen';

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Chat'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(
              kPadding,
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
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
                                //Do something with the user input.
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
                              //Implement send functionality.
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
            ),
          )),
    );
  }
}
