import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/strings.dart';

class JobApi {
  static const String baseUrl = AppStrings.BASE_URL;

  static Future<Map<String, dynamic>> addJob({
    required String title,
    required String description,
    required String qualification,
    required String mode,
    required String industry,
    required String minSalary,
    required String maxSalary,
    required String jobType,
    required String expReq,
    required String recruiterId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/job/jobs'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'recruiter_id': recruiterId,
        'title': title,
        'description': description,
        'qualificationRequired': qualification,
        'mode': mode,
        'industry': industry,
        'minSalary': minSalary,
        'maxSalary': maxSalary,
        'jobType': jobType,
        'experienceReq': expReq,
      }),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> updateJobUrl(
      String jobId, String newUrl) async {
    final response = await http.put(
      Uri.parse('$baseUrl/job/jobs/update/$jobId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'newUrl': newUrl,
      }),
    );

    return jsonDecode(response.body);
  }
}
