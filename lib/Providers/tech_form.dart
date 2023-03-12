import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormModel extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();

  String? name;
  String? email;
  String? issueTopic;
  String? issueDescription;
  String? status;
  String? createdAt;
  String? updatedAt;

  GlobalKey<FormState> get formKey => _formKey;

  Future<void> submitForm() async {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();

      final response = await http.post(
        Uri.parse('https://development.himam.com/api/technical-support'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'issueTopic': issueTopic,
          'issueDescription': issueDescription,
        }),
      );

      if (response.statusCode == 200) {
        status = 'Success';

        notifyListeners();
      } else {}
    }
  }
}
