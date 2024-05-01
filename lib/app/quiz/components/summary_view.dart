import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class QuizSummaryView extends StatelessWidget {
  const QuizSummaryView({super.key, required this.file});

  final File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quiz Attempt Summary",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: PDFView(
        filePath: file.path,
      ),
    );
  }
}
