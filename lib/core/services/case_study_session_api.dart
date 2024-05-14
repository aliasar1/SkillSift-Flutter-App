import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/strings.dart';
import '../models/case_study_session_model.dart';

class CaseStudySessionService {
  static const String baseUrl = AppStrings.BASE_URL;

  static CaseStudySession? parseSession(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return CaseStudySession.fromJson(parsed);
  }

  static Future<CaseStudySession?> addStartTime(
      String applicationId, String question, String res) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/caseStudySession/$applicationId'),
        body: {
          'question': question,
          'response': res,
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return parseSession(response.body);
      } else {
        throw Exception('Failed to add start time: ${response.body}');
      }
    } catch (error) {
      throw Exception('Failed to add start time: $error');
    }
  }

  static Future<Map<String, dynamic>> getSessionData(
      String applicationId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/caseStudySession/$applicationId'));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return {
          'data': parsed['session'],
          'isSessionExist': true,
        };
      } else if (response.statusCode == 404) {
        return {'isSessionExist': false};
      } else {
        throw Exception('Failed to calculate remaining time: ${response.body}');
      }
    } catch (error) {
      throw Exception('Failed to calculate remaining time: $error');
    }
  }

  static Future<void> saveProgress(String applicationId, String question,
      String res, String status, String submissionTime) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/caseStudySession/save-progress/$applicationId'),
        body: {
          'question': question,
          'response': res,
          'status': status,
          'submissionTime': submissionTime,
        },
      );
      print(response.body);
      if (response.statusCode != 200) {
        throw Exception('Failed to save progress: ${response.body}');
      }
    } catch (error) {
      throw Exception('Failed to save progress: $error');
    }
  }
}
