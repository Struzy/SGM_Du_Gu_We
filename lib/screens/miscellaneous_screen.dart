import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../constants/pdf_directory.dart';

class OperationSpreaderTruckScreen extends StatefulWidget {
  const OperationSpreaderTruckScreen({super.key});

  static const String id = 'operation_spreader_truck_screen';

  @override
  OperationSpreaderTruckScreenState createState() => OperationSpreaderTruckScreenState();
}

class OperationSpreaderTruckScreenState extends State<OperationSpreaderTruckScreen> {
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
          'Anweisung Abstreuwagen',
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
          kPDFMiscellaneous,
          key: pdfViewerKey,
        ),
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
