import 'dart:convert';

import 'package:skillsift_flutter_app/core/exports/constants_exports.dart';
import 'package:http/http.dart' as http;

class RecruiterApi {
  static const baseUrl = AppStrings.BASE_URL;

  static Future<Map<String, dynamic>> updateProfileUrl(
      String id, String newUrl) async {
    final response = await http.put(
      Uri.parse('$baseUrl/recruiterprofile/update-url/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'newUrl': newUrl,
      }),
    );
    print(response.body);
    return jsonDecode(response.body);
  }
}
