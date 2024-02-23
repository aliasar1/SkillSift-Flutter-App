import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skillsift_flutter_app/core/exports/constants_exports.dart';

class AuthApi {
  static const baseUrl = AppStrings.BASE_URL;

  static Future<Map<String, dynamic>> register({
    required String fullname,
    required String contactNo,
    required String email,
    required String password,
    required bool isRecruiter,
  }) async {
    final url = isRecruiter
        ? Uri.parse('$baseUrl/recruiter/register')
        : Uri.parse('$baseUrl/jobseeker/register');
    print(url);
    final response = await http.post(
      url,
      body: jsonEncode({
        'fullname': fullname,
        'contact_no': contactNo,
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);

    return jsonDecode(response.body);
  }

  // Login for job seeker
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/authenticate/login');
    final response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    return jsonDecode(response.body);
  }

  // Get current logged-in job seeker
  static Future<Map<String, dynamic>> getCurrentJobSeeker() async {
    final url = Uri.parse('$baseUrl/current-jobseeker');
    final response = await http.get(url);

    return jsonDecode(response.body);
  }
}
