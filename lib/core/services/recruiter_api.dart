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
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> updateRecruiterInfo(
      String id, String name, String contact) async {
    final response = await http.put(
      Uri.parse('$baseUrl/recruiterprofile/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fullname': name,
        'contact_no': contact,
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> updatePassword(
      String id, String oldPass, String newPassword) async {
    final response = await http.put(
      Uri.parse('$baseUrl/password/update/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'oldPassword': oldPass,
        'newPassword': newPassword,
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getRecruiterWithCompanyDetails(
      String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/recruiter/recruiter-company/$id'),
    );
    return jsonDecode(response.body);
  }
}
