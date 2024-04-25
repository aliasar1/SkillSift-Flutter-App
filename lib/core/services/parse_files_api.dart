import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skillsift_flutter_app/core/exports/constants_exports.dart';

class NlpApi {
  static var baseUrl = AppStrings.BASE_PARSER_URL;

  static Future<Map<String, dynamic>> processCVToRate(
      String cvUrl, String jdUrl) async {
    final url = Uri.parse('$baseUrl/process_cv_to_rate');
    final body = jsonEncode({'cv_url': cvUrl, 'jd_url': jdUrl});
    final response = await http.post(url, body: body, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to process CV: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> processJD(String pdfUrl) async {
    try {
      final url = Uri.parse('$baseUrl/process_jd');
      final body = jsonEncode({'pdf_url': pdfUrl});
      print(url);
      final response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
      });
      print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to process job description: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to process job description: ');
    }
  }
}
