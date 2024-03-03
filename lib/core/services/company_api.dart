import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skillsift_flutter_app/core/exports/constants_exports.dart';

import '../models/company_model.dart';

class CompanyApi {
  static const baseUrl = AppStrings.BASE_URL;

  static Future<Company?> getCompanyInfo(String id) async {
    final url = Uri.parse('$baseUrl/company/getCompanyInfo/$id');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 201) {
      Company company = Company.fromJson(jsonDecode(response.body)['data']);
      return company;
    } else {
      return null;
    }
  }
}
