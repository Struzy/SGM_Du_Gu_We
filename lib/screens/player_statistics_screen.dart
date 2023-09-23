import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../constants/pdf_directory.dart';

class PlayerStatisticsScreen extends StatefulWidget {
  const PlayerStatisticsScreen({super.key});

  static const String id = 'player_statistics_screen';

  @override
  PlayerStatisticsScreenState createState() => PlayerStatisticsScreenState();
}

class PlayerStatisticsScreenState extends State<PlayerStatisticsScreen> {
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
          'Ewige Spielerliste',
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
          kPDFPlayerStatistics,
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
