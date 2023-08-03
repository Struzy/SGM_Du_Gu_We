import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../constants/pdf_directory.dart';
import '../widgets/navigation_drawer.dart' as nav;

class MiscellaneousScreen extends StatefulWidget {
  const MiscellaneousScreen({super.key});

  static const String id = 'miscellaneous_screen';

  @override
  MiscellaneousScreenState createState() => MiscellaneousScreenState();
}

class MiscellaneousScreenState extends State<MiscellaneousScreen> {
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  final PdfViewerController pdfViewerController = PdfViewerController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const nav.NavigationDrawer(),
      appBar: AppBar(
        title: const Text(
          'Anweisung Abstreuwagen',
        ),
        actions: [
          IconButton(
            onPressed: pdfViewerKey.currentState?.openBookmarkView,
            icon: const Icon(
              Icons.bookmark,
            ),
          ),
        ],
      ),
      body: SfPdfViewer.network(
        kPDFMiscellaneous,
        key: pdfViewerKey,
      ),
    );
  }

  // Show snack bar
  void showSnackBar(String snackBarText) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          snackBarText,
        ),
      ),
    );
  }
}
