import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skillsift_flutter_app/core/exports/constants_exports.dart';

class AuthApi {
  static const baseUrl = AppStrings.BASE_URL;

  static Future<http.Response> register({
    required String fullname,
    required String contactNo,
    required String email,
    required String password,
    required bool isRecruiter,
  }) async {
    final url = isRecruiter
        ? Uri.parse('$baseUrl/recruiter/register')
        : Uri.parse('$baseUrl/jobseeker/register');
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

    return response;
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
  static Future<Map<String, dynamic>> getCurrentUser(
      bool isRecruiter, String id) async {
    final url = isRecruiter
        ? Uri.parse('$baseUrl/recruiter/current/$id')
        : Uri.parse('$baseUrl/jobseeker/current/$id');
    final response = await http.get(url);

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> registerCompany({
    required String companyName,
    required String industryOrSector,
    required String companySize,
    required String contactNo,
    required String contactEmail,
    required String street1,
    required String city,
    required String state,
    required List<double> geolocation,
    required String country,
    required String postalCode,
    required String id,
  }) async {
    final url = Uri.parse('$baseUrl/company/updateInfo/$id');
    final response = await http.post(
      url,
      body: jsonEncode({
        'companyName': companyName,
        'industry': industryOrSector,
        'companySize': companySize,
        'geolocation': geolocation,
        'companyPhone': contactNo,
        'companyEmail': contactEmail,
        'street': street1,
        'city': city,
        'state': state,
        'country': country,
        'postalCode': postalCode,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    return jsonDecode(response.body);
  }
}
