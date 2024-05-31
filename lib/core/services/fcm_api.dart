// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skillsift_flutter_app/core/exports/constants_exports.dart';

class FCMNotificationsApi {
  static const baseUrl = AppStrings.BASE_URL;

  static Future<bool> registerToken(String fcmToken, String userId) async {
    final url = Uri.parse('$baseUrl/notifications/registerToken');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'fcmToken': fcmToken,
        'userId': userId,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to register token: ${response.body}');
      return false;
    }
  }

  static Future<bool> removeToken(String fcmToken, String userId) async {
    final url = Uri.parse('$baseUrl/notifications/removeToken');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'fcmToken': fcmToken,
        'userId': userId,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to remove token: ${response.body}');
      return false;
    }
  }

  static Future<bool> sendNotification(
      String fcmToken, String title, String body) async {
    final url = Uri.parse('$baseUrl/notifications/send');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'fcmToken': fcmToken,
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to send notification: ${response.body}');
      return false;
    }
  }

  static Future<List<String>?> getAllTokensOfUser(String userId) async {
    final url = Uri.parse('$baseUrl/notifications/tokens/$userId');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      List<dynamic> tokens = jsonDecode(response.body);
      return tokens.cast<String>();
    } else {
      print('Failed to fetch tokens: ${response.body}');
      return null;
    }
  }

  static Future<void> sendNotificationToAllTokens(
      List<String>? tokens, String title, String body) async {
    if (tokens == null) {
      print('No tokens found for user.');
      return;
    }

    for (String token in tokens) {
      bool success = await sendNotification(token, title, body);
      if (!success) {
        print('Failed to send notification to token: $token');
      }
    }
  }
}
