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

  late double zoomLevel;

  @override
  void initState() {
    super.initState();
    zoomLevel = 1.0;
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
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'zoomIn') {
                zoomIn();
              } else if (value == 'zoomOut') {
                zoomOut();
              } else if (value == 'previousPage') {
                goToPreviousPage();
              } else if (value == 'nextPage') {
                goToNextPage();
              } else if (value == 'bookmarkMenu') {
                pdfViewerKey.currentState?.openBookmarkView();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'zoomIn',
                child: ListTile(
                  title: Icon(
                    Icons.zoom_in,
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'zoomOut',
                child: ListTile(
                  title: Icon(
                    Icons.zoom_out,
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'previousPage',
                child: ListTile(
                  title: Icon(
                    Icons.navigate_before,
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'nextPage',
                child: ListTile(
                  title: Icon(
                    Icons.navigate_next,
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'bookmarkMenu',
                child: ListTile(
                  title: Icon(
                    Icons.bookmark,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SfPdfViewer.network(
        kPDFMiscellaneous,
        key: pdfViewerKey,
      ),
    );
  }

  // Zoom the pdf in
  void zoomIn() {
    setState(() {
      zoomLevel += 0.25;
      pdfViewerController.zoomLevel = zoomLevel;
    });
  }

  // Zoom the pdf out
  void zoomOut() {
    setState(() {
      zoomLevel -= 0.25;
      pdfViewerController.zoomLevel = zoomLevel;
    });
  }

  // Go to the next pdf page
  void goToNextPage() {
    pdfViewerController.nextPage();
  }

  // Go to the previous pdf page
  void goToPreviousPage() {
    pdfViewerController.previousPage();
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
