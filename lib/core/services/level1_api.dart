import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/strings.dart';
import '../models/level1_model.dart';

class Level1Api {
  static const baseUrl = AppStrings.BASE_URL;

  static Future<void> createLevel1(Level1 level1) async {
    final response = await http.post(
      Uri.parse('$baseUrl/level1'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(level1.toJson()),
    );
    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to create level1');
    }
  }

  static Future<Level1> getLevel1ById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/level1/$id'));

    if (response.statusCode == 200) {
      return Level1.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get level1 by ID');
    }
  }

  static Future<Level1> updateLevel1(String id, Level1 level1) async {
    final response = await http.put(
      Uri.parse('$baseUrl/level1/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(level1.toJson()),
    );

    if (response.statusCode == 200) {
      return Level1.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update level1');
    }
  }

  static Future<void> deleteLevel1(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/level1/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete level1');
    }
  }
}
