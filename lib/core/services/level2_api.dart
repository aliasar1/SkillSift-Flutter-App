import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/strings.dart';
import '../models/level2_model.dart';

class Level2Api {
  static const baseUrl = AppStrings.BASE_URL;

  static Future<Level2> addScore(
      String applicationId, int score, String status, String qnaId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/level2'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'application_id': applicationId,
        'score': score,
        'status': status,
        'qna_id': qnaId,
      }),
    );

    if (response.statusCode == 201) {
      return Level2.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to add score');
    }
  }

  static Future<Level2> getScoreByApplicationId(String applicationId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/level2/by-application/$applicationId'));
    print(response.body);

    if (response.statusCode == 200) {
      return Level2.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get level2 by ID');
    }
  }

  static Future<bool> checkIfApplicationIdExists(String applicationId) async {
    try {
      final url = Uri.parse('$baseUrl/level2/exists/$applicationId');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['success'] && responseData['exists'];
      } else {
        throw Exception('Failed to check application ID existence');
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<Level2> updateStatusByApplicationId(
      String applicationId, String status) async {
    final response = await http.put(
      Uri.parse('$baseUrl/level2/$applicationId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'status': status,
      }),
    );

    if (response.statusCode == 200) {
      return Level2.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to update status');
    }
  }
}
