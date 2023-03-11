import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/tag_class.dart';

class TagService {
  static const String apiUrl = 'https://development.himam.com/api/library/tags';

  static Future<List<Tag>> getTags() async {
    final response = await http.get(Uri.parse(apiUrl));
    final List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((json) => Tag.fromJson(json)).toList();
  }
}
