import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/strings.dart';
import '../models/job_model.dart';

class JobApi {
  static const String baseUrl = AppStrings.BASE_URL;

  static Future<Map<String, dynamic>> addJob({
    required String title,
    required String description,
    required List<String> tags,
    required String qualification,
    required String mode,
    required String industry,
    required double minSalary,
    required double maxSalary,
    required String jobType,
    required String expReq,
    required String recruiterId,
    required String deadline,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/job/jobs'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'recruiter_id': recruiterId,
        'title': title,
        'description': description,
        'skill_tags': tags,
        'qualification_required': qualification,
        'experience_required': expReq,
        'mode': mode,
        'type': jobType,
        'industry': industry,
        'min_salary': minSalary,
        'max_salary': maxSalary,
        'deadline': deadline,
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> updateJob({
    required String jobId,
    required String title,
    required String description,
    required List<String> tags,
    required String qualification,
    required String experience,
    required String mode,
    required String jobType,
    required String industry,
    required double minSalary,
    required double maxSalary,
    required String deadline,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/job/jobs/$jobId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'description': description,
        'skill_tags': tags,
        'qualification_required': qualification,
        'experience_required': experience,
        'mode': mode,
        'type': jobType,
        'industry': industry,
        'min_salary': minSalary,
        'max_salary': maxSalary,
        'deadline': deadline,
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

  static Future<List<Job>> getAllJobs() async {
    final response = await http.get(Uri.parse('$baseUrl/job/jobs'));
    final List<dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((json) => Job.fromJson(json)).toList();
  }

  static Future<Map<String, dynamic>> deleteJob(String jobId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/job/jobs/$jobId'),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }

  // static Future<List<Job>> getAllJobsWithCompanyDetails() async {
  //   final response =
  //       await http.get(Uri.parse('$baseUrl/job/jobs/jobs-company'));
  //   print(response.body);
  //   final List<dynamic> jsonResponse = jsonDecode(response.body);
  //   print(jsonResponse);
  //   return jsonResponse.map((json) => Job.fromJson(json)).toList();
  // }
}
