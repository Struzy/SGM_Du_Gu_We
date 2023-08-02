import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart' as path;
import 'package:sgm_du_gu_we/services/pdf_viewer_service.dart';
import '../constants/padding.dart';
import '../constants/spin_kit_double_bounce.dart';

class MiscellaneousScreen extends StatefulWidget {
  const MiscellaneousScreen({super.key});

  static const String id = 'miscellaneous_screen';

  @override
  MiscellaneousScreenState createState() => MiscellaneousScreenState();
}

class MiscellaneousScreenState extends State<MiscellaneousScreen> {
  String pdfUrl =
      'gs://sgm-duguwe.appspot.com/Sonstiges/Anweisung und Betreiben des Farb-Abstreuwagens_2020.pdf'; // Replace with your PDF URL

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(
            kPadding,
          ),
          child: Center(
            child: ElevatedButton(
              onPressed: () => loadPdfFromFirebaseStorage(),
              child: const Text('Open PDF'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loadPdfFromFirebaseStorage() async {
    // Create a FirebaseStorage instance and get the reference to your PDF
    final Reference pdfRef = FirebaseStorage.instance.refFromURL(pdfUrl);

    // Download the PDF to a temporary file and get its local path
    final String localPath = (await pdfRef.getDownloadURL()).toString();

    // Navigate to the PDF view page passing the local path
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewerScreen(
          pdfPath: localPath,
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

class PDFViewerScreen extends StatefulWidget {
  const PDFViewerScreen({super.key, required this.pdfPath});

  final String pdfPath;

  @override
  PDFViewerScreenState createState() => PDFViewerScreenState();
}

class PDFViewerScreenState extends State<PDFViewerScreen> {

  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final name = 'Anweisung';
    final text = '${indexPage + 1} of $pages';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: pages >= 2
            ? [
                Center(child: Text(text)),
                IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 32,
                  ),
                  onPressed: () {
                    final page = indexPage == 0 ? pages : indexPage - 1;
                    controller.setPage(page);
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.chevron_right,
                    size: 32,
                  ),
                  onPressed: () {
                    final page = indexPage == pages - 1 ? 0 : indexPage + 1;
                    controller.setPage(page);
                  },
                ),
              ]
            : null,
      ),
      body: PDFView(
        filePath: widget.pdfPath,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        defaultPage: 0,
        fitPolicy: FitPolicy.BOTH,
        preventLinkNavigation: false,
        onRender: (_pages) {
          // Called when PDF document is rendered and ready to be displayed
        },
        onError: (error) {
          // Error occurred while opening the PDF
          print(error.toString());
        },
        onPageError: (page, error) {
          // Error occurred while displaying a specific page
          print('Error on page $page: ${error.toString()}');
        },
        onViewCreated: (PDFViewController controller) {
          // Controller is created and available for usage
          // You can use the controller to jump to a specific page, etc.
        },
      ),
    );
  }
}

// int progress = 0;
// @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         drawer: const NavigationDrawer(),
//         appBar: AppBar(
//           title: const Text('Kreisliga A2 Schwarzwald'),
//         ),
//         body: Column(
//           children: [
//             LinearProgressIndicator(
//               value: progress / 100,
//               backgroundColor: Colors.grey[200],
//               valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
//             ),
//             Expanded(
//               child: WebView(
//                 initialUrl:
//                 'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.'
//                     'com/o/Sonstiges%2FAnweisung%20und%20Betreiben%20des%20Farb-'
//                     'Abstreuwagens_2020.pdf?alt=media&token=6cd1b2f9-c3ee-461b-'
//                     '83d2-2782b8190916',
//                 javascriptMode: JavascriptMode.unrestricted,
//                 onProgress: (int newProgress) {
//                   setState(() {
//                     progress = newProgress;
//                   });
//                 },
//                 onPageFinished: (String url) {
//                   setState(() {
//                     progress = 0;
//                   });
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         drawer: const NavigationDrawer(),
//         appBar: AppBar(
//           title: const Text('Sonstiges'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(
//             kPadding,
//           ),
//           child: Center(
//             child: Image.network(
//               fit: BoxFit.cover,
//               'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Sonstiges%2Fmiscellaneous.PNG?alt=media&token=9c411359-268e-4c7a-beb1-b0bbbde08664',
//               loadingBuilder: (BuildContext context, Widget child,
//                   ImageChunkEvent? loadingProgress) {
//                 if (loadingProgress == null) {
//                   isLoading = false;
//                   return child;
//                 }
//                 return const CircularProgressIndicator();
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
