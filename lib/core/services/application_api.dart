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

  static Future<int> getTotalApplicationsOfJob(String id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/applications/job/application-count/$id'));
    if (response.statusCode == 200) {
      dynamic jsonResponse = jsonDecode(response.body);
      int count = jsonResponse['count'];
      return count;
    } else {
      throw Exception('Failed to get total applications of job');
    }
  }

  static Future<List<Application>> findApplicationsByJobId(String jobId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/applications/job/$jobId'));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      List<Application> applications =
          data.map((json) => Application.fromJson(json)).toList();
      print("Len: ${applications.length}");
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

  static Future<String> getApplicationStatus(String id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/applications/status/$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['application_status'];
    } else {
      throw Exception('Failed to get application status');
    }
  }

  static Future<List<Application>> getApplicationsByJobSeeker(String id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/applications/jobseeker/$id'));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      List<Application> applications =
          data.map((json) => Application.fromJson(json)).toList();
      return applications;
    } else {
      throw Exception('Failed to get applications by job seeker');
    }
  }

  static Future<Map<String, dynamic>> updateApplicationStatusAndLevel(
      String applicationId, String status, String currentLevel) async {
    try {
      final url = Uri.parse('$baseUrl/applications/update-status');
      var resp = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'applicationId': applicationId,
          'status': status,
          'currentLevel': currentLevel,
          'applicationStatus': status == 'rejected'
              ? "rejected"
              : (currentLevel == "1" ||
                          currentLevel == "2" ||
                          currentLevel == "3") &&
                      status == "accepted"
                  ? currentLevel == "3"
                      ? "accepted"
                      : "pending"
                  : "pending",
        }),
      );
      print(jsonDecode(resp.body));
      return jsonDecode(resp.body);
    } catch (e) {
      throw Exception('Failed to update application status and level: $e');
    }
  }

  static Future<int> findTheMaxLevel(String jobId) async {
    try {
      final url = Uri.parse('$baseUrl/applications/max-level/$jobId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody['maxLevel'] is int) {
          int maxLevel = responseBody['maxLevel'];
          return maxLevel;
        } else if (responseBody['maxLevel'] is String) {
          int maxLevel = int.parse(responseBody['maxLevel']);
          return maxLevel;
        } else {
          throw Exception('Unexpected type for maxLevel');
        }
      } else {
        throw Exception('Failed to load applications');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
