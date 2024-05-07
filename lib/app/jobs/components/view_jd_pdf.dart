import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../../core/services/pdf_view_api.dart';

class JdPdfViewer extends StatefulWidget {
  const JdPdfViewer({super.key, required this.url});

  @override
  // ignore: library_private_types_in_public_api
  _JdPdfViewerPageState createState() => _JdPdfViewerPageState();

  final String url;
}

class _JdPdfViewerPageState extends State<JdPdfViewer> {
  String? localPath;

  @override
  void initState() {
    super.initState();

    ApiServiceProvider.loadPDF(widget.url).then((value) {
      setState(() {
        localPath = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Job Description PDF",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: localPath != null
          ? PDFView(
              filePath: localPath,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
