import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ApiServiceProvider {

  static Future<String> loadPDF(String url) async {
    var response = await http.get(Uri.parse(url));

    var dir = await getApplicationDocumentsDirectory();
    File file =  File("${dir.path}/data.pdf");
    file.writeAsBytesSync(response.bodyBytes, flush: true);
    return file.path;
  }
}
