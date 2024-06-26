// services/interview_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/strings.dart';
import '../models/interview_model.dart';

class InterviewApi {
  static const baseUrl = AppStrings.BASE_URL;
  static Future<bool> scheduleInterview(InterviewSchedule interview) async {
    final url = Uri.parse('$baseUrl/interview/schedule');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(interview.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to schedule interview: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> checkInterviewExists(
      String applicationId) async {
    final url = Uri.parse('$baseUrl/interview/check');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'application_id': applicationId}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to check interview: ${response.body}');
    }
  }

  static Future<void> sendInterviewEmail(String data, String email) async {
    try {
      final url = Uri.parse('$baseUrl/interview/sendEmail');
      final response = await http.post(
        url,
        body: jsonEncode(<String, dynamic>{
          'data': data,
          'email': email,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        print('Interview email sent successfully!');
      } else {
        throw Exception('Failed to send email: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to send interview email: $e');
    }
  }
}
