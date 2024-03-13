import 'dart:convert';

import 'package:http/http.dart' as http;
import '../constants/strings.dart';
import '../models/job_model.dart';

class SearchApi {
  static const baseUrl = AppStrings.BASE_URL;

  static Future<List<Job>?> searchJobs(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/job/jobs/search/$id'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((jobJson) => Job.fromJson(jobJson)).toList();
    } else {
      return null;
    }
  }
}
