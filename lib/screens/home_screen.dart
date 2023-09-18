import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/font_size.dart';
import '../constants/box_size.dart';
import '../constants/color.dart';
import '../constants/font_family.dart';
import '../constants/padding.dart';
import '../constants/squad_directory.dart';
import '../widgets/navigation_drawer.dart' as nav;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = 'home_screen';

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const nav.NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Hauptmenü'),
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
                  const Text(
                    'Herzlich willkommen bei der',
                    style: TextStyle(
                      fontSize: kFontsizeSubtitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  const Text(
                    'SGM',
                    style: TextStyle(
                      fontFamily: kPacifico,
                      fontSize: kFontsizeTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Durchhausen',
                    style: TextStyle(
                      fontFamily: kPacifico,
                      fontSize: kFontsizeTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Gunningen',
                    style: TextStyle(
                      fontFamily: kPacifico,
                      fontSize: kFontsizeTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Weigheim',
                    style: TextStyle(
                      fontFamily: kPacifico,
                      fontSize: kFontsizeTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  const Text(
                    'Durchhausen/Gunningen:',
                    style: TextStyle(
                      fontSize: kFontsizeSubtitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  Image.network(
                    kFirstSquadImage,
                    loadingBuilder: loadingBuilder,
                  ),
                  const SizedBox(
                    height: kBoxHeight + 20.0,
                  ),
                  const Text(
                    'Weigheim:',
                    style: TextStyle(
                      fontSize: kFontsizeSubtitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: kBoxHeight,
                  ),
                  Image.network(
                    kSecondSquadImage,
                    loadingBuilder: loadingBuilder,
                  ),
                ],
              ),
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
