import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skillsift_flutter_app/core/models/quiz_summary_model.dart';
import 'package:skillsift_flutter_app/core/constants/strings.dart';

class QuizSummaryApi {
  static const baseUrl = AppStrings.BASE_URL;

  static Future<bool> addQuizSummary(
      String applicationId, List<QuizSummary> quizSummaries) async {
    final url = Uri.parse('$baseUrl/summary');
    final List<Map<String, dynamic>> summariesJson =
        quizSummaries.map((summary) => summary.toJson()).toList();
    final body = json
        .encode({'responses': summariesJson, 'application_id': applicationId});

    final response = await http.post(
      url,
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add quiz summaries');
    }
  }

  static Future<List<QuizSummary>> getQuizSummariesByApplicationId(
      String applicationId) async {
    final url = Uri.parse('$baseUrl/summary/$applicationId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      List<QuizSummary> quizSummaries = [];
      for (var data in responseData) {
        List<dynamic> responsesData = data['responses'];
        for (var responseData in responsesData) {
          quizSummaries.add(QuizSummary.fromJson(responseData));
        }
      }
      return quizSummaries;
    } else {
      throw Exception('Failed to load quiz summaries');
    }
  }
}
