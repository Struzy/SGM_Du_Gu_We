import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../constants/pdf_directory.dart';
import '../widgets/navigation_drawer.dart' as nav;

class LyricsScreen extends StatefulWidget {
  const LyricsScreen({super.key});

  static const String id = 'lyrics_screen';

  @override
  LyricsScreenState createState() => LyricsScreenState();
}

class LyricsScreenState extends State<LyricsScreen> {
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
          'Liedtexte',
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
        kPDFSongtexts,
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
