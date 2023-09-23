import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../constants/pdf_directory.dart';

class BaarCupScreen extends StatefulWidget {
  const BaarCupScreen({super.key});

  static const String id = 'baar_cup_screen';

  @override
  BaarCupScreenState createState() => BaarCupScreenState();
}

class BaarCupScreenState extends State<BaarCupScreen> {
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  final PdfViewerController pdfViewerController = PdfViewerController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Baar-Pokal Tuningen 2023',
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SfPdfViewer.network(
          kPDFBaarCup,
          key: pdfViewerKey,
        ),
      ),
    );
  }
}
