import 'package:flutter/material.dart';
import '../constants/padding.dart';
import '../widgets/navigation_drawer.dart';

class PenaltyCatalogScreen extends StatefulWidget {
  const PenaltyCatalogScreen({super.key});

  static const String id = 'penalty_catalog_screen';

  @override
  PenaltyCatalogScreenState createState() => PenaltyCatalogScreenState();
}

class PenaltyCatalogScreenState extends State<PenaltyCatalogScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Strafenkatalog'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Center(
            child: Image.network(
              fit: BoxFit.cover,
              'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Strafenkatalog%2Fpenalty_catalog.PNG?alt=media&token=4e970b3a-d993-4b2f-9f01-d5e7870a8dbb',
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
