import 'package:flutter/material.dart';
import '../constants/padding.dart';

class MiscellaneousScreen extends StatefulWidget {
  const MiscellaneousScreen({super.key});

  static const String id = 'miscellaneous_screen';

  @override
  MiscellaneousScreenState createState() => MiscellaneousScreenState();
}

class MiscellaneousScreenState extends State<MiscellaneousScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sonstiges'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Center(
            child: Image.network(
              fit: BoxFit.cover,
              'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Sonstiges%2Fmiscellaneous.PNG?alt=media&token=9c411359-268e-4c7a-beb1-b0bbbde08664',
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  isLoading = false;
                  return child;
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
