import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PenaltyCatalogScreen extends StatefulWidget {
  const PenaltyCatalogScreen({super.key});

  static const String id = 'penalty_catalog_screen';

  @override
  PenaltyCatalogScreenState createState() => PenaltyCatalogScreenState();
}

class PenaltyCatalogScreenState extends State<PenaltyCatalogScreen> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int progress = 0;
  String remotePDFpath = '';
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();

    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Strafenkatalog'),
        ),
        body: Stack(
          children: <Widget>[
            LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            PDFView(
              filePath: 'gs://sgm-duguwe.appspot.com/Strafenkatalog/Strafenkatalog SGM.pdf',
              enableSwipe: false,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: true,
              pageSnap: true,
              defaultPage: currentPage!,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation: false,
              onRender: (pages) {
                setState(() {
                  pages = pages;
                  isReady = true;
                });
              },
              onError: (error) {
                setState(() {
                  errorMessage = error.toString();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorMessage),
                  ),
                );
              },
              onPageError: (page, error) {
                setState(() {
                  errorMessage = '$page: ${error.toString()}';
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$page: ${error.toString()}'),
                  ),
                );
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
              onLinkHandler: (String? uri) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Go to uri: $uri'),
                  ),
                );
              },
              onPageChanged: (int? page, int? total) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Page change: $page/$total'),
                  ),
                );
                setState(() {
                  currentPage = page;
                });
              },
            ),
            errorMessage.isEmpty
                ? !isReady
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container()
                : Center(
                    child: Text(errorMessage),
                  )
          ],
        ),
      ),
    );
  }

  // Create file of PDF URL
  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    try {
      const url =
          'gs://sgm-duguwe.appspot.com/Strafenkatalog/Strafenkatalog SGM.pdf';
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file');
    }

    return completer.future;
  }
}
