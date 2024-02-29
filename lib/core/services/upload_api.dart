import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/strings.dart';

class UploadApi {
  static const String baseUrl = AppStrings.BASE_URL;

  static Future<String> uploadFile(String directory, String filePath) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/s3/upload/$directory');
      var request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      request.headers.addAll({'Content-Type': 'application/json'});
      var response = await request.send();
      if (response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
        final String url = jsonResponse['url'];
        return url;
      } else {
        throw Exception('Failed to upload file');
      }
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }

  static Future<List<String>> listFiles() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/list'));
      if (response.statusCode == 200) {
        final List<dynamic> filesJson = json.decode(response.body);
        return filesJson.map((file) => file.toString()).toList();
      } else {
        throw Exception('Failed to list files');
      }
    } catch (e) {
      throw Exception('Failed to list files: $e');
    }
  }

  static Future<void> downloadFile(String filename) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/download/$filename'));
      // Handle the response based on your requirements
    } catch (e) {
      throw Exception('Failed to download file: $e');
    }
  }

  static Future<void> deleteFile(String filename) async {
    try {
      final response =
          await http.delete(Uri.parse('$baseUrl/delete/$filename'));
      if (response.statusCode != 200) {
        throw Exception('Failed to delete file');
      }
    } catch (e) {
      throw Exception('Failed to delete file: $e');
    }
  }
}
