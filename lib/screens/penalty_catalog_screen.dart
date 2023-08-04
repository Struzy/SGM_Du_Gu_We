import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../constants/pdf_directory.dart';
import '../widgets/navigation_drawer.dart' as nav;

class PenaltyCatalogScreen extends StatefulWidget {
  const PenaltyCatalogScreen({super.key});

  static const String id = 'penalty_catalog_screen';

  @override
  PenaltyCatalogScreenState createState() => PenaltyCatalogScreenState();
}

class PenaltyCatalogScreenState extends State<PenaltyCatalogScreen> {
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  final PdfViewerController pdfViewerController = PdfViewerController();

  static final year = DateTime
      .now()
      .year;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const nav.NavigationDrawer(),
      appBar: AppBar(
        title: Text(
          'Strafenkatalog SGM $year',
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
      body: SfPdfViewer.network(
        kPDFPenaltyCatalog,
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
