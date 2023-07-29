import 'package:flutter/material.dart';
import '../constants/color.dart';
import '../constants/padding.dart';
import '../widgets/navigation_drawer.dart';

class PreparationPlanScreen extends StatefulWidget {
  const PreparationPlanScreen({super.key});

  static const String id = 'preparation_plan_screen';

  @override
  PreparationPlanScreenState createState() => PreparationPlanScreenState();
}

class PreparationPlanScreenState extends State<PreparationPlanScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Vorbereitungsplan'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Center(
            child: Image.network(
              fit: BoxFit.cover,
              'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Vorbereitungsplan%2Fpreparation_plan.PNG?alt=media&token=43011017-dc96-4e69-93be-b2e3d042fe10',
              loadingBuilder: loadingBuilder,
            ),
          ),
        ),
      ),
    );
  }

  // Loading builder
  Widget loadingBuilder(BuildContext context, Widget child,
      ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      isLoading = false;
      return child;
    }
    return const CircularProgressIndicator(
      color: kSGMColorGreen,
    );
  }
}
