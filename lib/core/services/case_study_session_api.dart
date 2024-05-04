import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/strings.dart';

class CaseStudySessionService {
  static const baseUrl = AppStrings.BASE_URL;

  static Future<void> addStartTime(String applicationId) async {
    const url = '$baseUrl/caseStudySession';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'applicationId': applicationId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add start time');
    }
  }

  static Future<int?> calculateRemainingTime(String id) async {
    final url = '$baseUrl/caseStudySession/remaining-time/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['remainingTime'];
    } else if (response.statusCode == 404) {
      // Session not found
      return null;
    } else {
      throw Exception('Failed to calculate remaining time');
    }
  }
}
