import 'package:flutter/material.dart';
import '../constants/padding.dart';
import '../widgets/navigation_drawer.dart';

class BaarCupScreen extends StatefulWidget {
  const BaarCupScreen({super.key});

  static const String id = 'baar_cup_screen';

  @override
  BaarCupScreenState createState() => BaarCupScreenState();
}

class BaarCupScreenState extends State<BaarCupScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Baarpokal 2023'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Center(
            child: Image.network(
              fit: BoxFit.cover,
              'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Baarpokal%2Fbaar_cup.PNG?alt=media&token=c54d0ef6-edf9-46dd-9c28-6b3a08c76a34',
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
