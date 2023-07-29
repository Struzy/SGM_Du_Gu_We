import 'package:flutter/material.dart';
import '../constants/padding.dart';
import '../widgets/navigation_drawer.dart';

class SprinklePlanScreen extends StatefulWidget {
  const SprinklePlanScreen({super.key});

  static const String id = 'sprinkle_plan_screen';

  @override
  SprinklePlanScreenState createState() => SprinklePlanScreenState();
}

class SprinklePlanScreenState extends State<SprinklePlanScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Abstreuplan'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Center(
            child: Image.network(
              fit: BoxFit.cover,
              'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Abstreuplan%2Fsprinkle_plan.PNG?alt=media&token=0768b914-ba49-4620-8c9a-ac7a9070be63',
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
