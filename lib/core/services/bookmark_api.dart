import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/strings.dart';

class BookmarkApi {
  static const String baseUrl = AppStrings.BASE_URL;

  static Future<Map<String, dynamic>> addBookmark({
    required String jobseekerId,
    required String jobId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bookmark/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'jobseeker_id': jobseekerId,
        'job_id': jobId,
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> removeBookmark({
    required String jobseekerId,
    required String jobId,
  }) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/bookmark/remove'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'jobseeker_id': jobseekerId,
        'job_id': jobId,
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getBookmarks(String jobseekerId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/bookmark/get/$jobseekerId'),
    );
    final jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }

  static Future<bool> checkBookmarkExists({
    required String jobseekerId,
    required String jobId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bookmark/getStatus'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'jobseeker_id': jobseekerId,
        'job_id': jobId,
      }),
    );
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse['exists'];
  }
}
