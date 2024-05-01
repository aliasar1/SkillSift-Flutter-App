import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

import '../models/quiz_summary_model.dart';

class PdfGenerator {
  static Future<File> generateQuizSummaryPdf(
      List<QuizSummary> quizSummaries) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(
            child: pw.Text('Quiz Summary',
                style: const pw.TextStyle(fontSize: 24)),
          );
        },
      ),
    );

    for (var summary in quizSummaries) {
      pdf.addPage(
        pw.Page(
          build: (context) {
            return pw.Column(
              children: [
                pw.Text('Question: ${summary.question}',
                    style: const pw.TextStyle(fontSize: 18)),
                pw.Text('Choices: ${summary.choices.join(", ")}',
                    style: const pw.TextStyle(fontSize: 16)),
                pw.Text('You answered: ${summary.userAnswer}',
                    style: const pw.TextStyle(fontSize: 16)),
                pw.Text('Correct Answer: ${summary.correctAns}',
                    style: const pw.TextStyle(fontSize: 16)),
                pw.Text('Status: ${summary.status}',
                    style: const pw.TextStyle(fontSize: 16)),
                pw.Divider(),
              ],
            );
          },
        ),
      );
    }
    final output = File('${Directory.systemTemp.path}/quiz_summary.pdf');
    await output.writeAsBytes(await pdf.save());
    return output;
  }
}
