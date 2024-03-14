import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/strings.dart';
import '../models/application_model.dart';

class ApplicationApi {
  static const baseUrl = AppStrings.BASE_URL;

  static Future<List<Application>> getAllApplications() async {
    final response = await http.get(Uri.parse('$baseUrl/applications'));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      List<Application> applications =
          data.map((json) => Application.fromJson(json)).toList();
      return applications;
    } else {
      throw Exception('Failed to load applications');
    }
  }

  static Future<Application> findApplicationById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/applications/$id'));
    if (response.statusCode == 200) {
      return Application.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to find application');
    }
  }

  static Future<List<Application>> findApplicationsByJobId(String jobId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/applications/job/$jobId'));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      List<Application> applications =
          data.map((json) => Application.fromJson(json)).toList();
      return applications;
    } else {
      throw Exception('Failed to find applications by job id');
    }
  }

  static Future<Application> apply(Application application) async {
    final response = await http.post(
      Uri.parse('$baseUrl/applications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(application.toJson()),
    );
    if (response.statusCode == 200) {
      return Application.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to apply');
    }
  }

  static Future<Map<String, dynamic>> updateCVUrl(
      String id, String newUrl) async {
    final response = await http.put(
      Uri.parse('$baseUrl/applications/update-url/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'newUrl': newUrl,
      }),
    );
    return jsonDecode(response.body);
  }
}
