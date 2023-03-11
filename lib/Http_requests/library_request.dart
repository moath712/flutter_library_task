import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/library_class.dart';

class ApiService {
  static const String apiUrl = 'https://development.himam.com/api/library';

  Future<List<HimamApi>> fetchLibrary() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => HimamApi.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load library');
    }
  }
}
