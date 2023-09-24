import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../constants/pdf_directory.dart';

// Widget for the long term training participation
class TrainingParticipationLongTerm extends StatefulWidget {
  const TrainingParticipationLongTerm({super.key});

  @override
  State<TrainingParticipationLongTerm> createState() =>
      TrainingParticipationLongTermState();
}

class TrainingParticipationLongTermState
    extends State<TrainingParticipationLongTerm> {
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  final PdfViewerController pdfViewerController = PdfViewerController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SfPdfViewer.network(
          kPDFTrainingParticipation,
          key: pdfViewerKey,
        ),
      ),
    );
  }
}
