import 'dart:convert';
import 'package:flutter/services.dart';

class UrlConfigHelper {
  Future<Map<String, dynamic>> readJson() async {
    final String response = await rootBundle.loadString('assets/config.json');
    final Map<String, dynamic> data = await json.decode(response);
    return data;
  }
}
