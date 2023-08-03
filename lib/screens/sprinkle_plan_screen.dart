import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../constants/pdf_directory.dart';
import '../widgets/navigation_drawer.dart' as nav;

class SprinklePlanScreen extends StatefulWidget {
  const SprinklePlanScreen({super.key});

  static const String id = 'sprinkle_plan_screen';

  @override
  SprinklePlanScreenState createState() => SprinklePlanScreenState();
}

class SprinklePlanScreenState extends State<SprinklePlanScreen> {
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
          'Abstreuplan Saison 23/24',
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
        kPDFSprinklePlan,
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
