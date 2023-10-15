import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class TokenMonitor extends StatefulWidget {
  const TokenMonitor(this.builder, {super.key});

  final Widget Function(String? token) builder;

  @override
  State<StatefulWidget> createState() => TokenMonitorState();
}

class TokenMonitorState extends State<TokenMonitor> {
  String? token;
  late Stream<String> tokenStream;

  void setToken(String? token) {
    setState(() {
      token = token;
    });
  }

  @override
  void initState() {
    super.initState();
    getMessagingToken().then(setToken);
    //FirebaseMessaging.instance.getToken().then(setToken);
    tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    tokenStream.listen(setToken);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(token);
  }
}

Future<String?> getMessagingToken() async {
  String? token = await FirebaseMessaging.instance.getToken();

  return token;
}
