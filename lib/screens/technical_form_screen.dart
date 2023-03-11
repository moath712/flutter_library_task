import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_library_task/screens/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final formProvider = ChangeNotifierProvider<FormModel>((ref) => FormModel());

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
        createdAt = DateTime.now().toIso8601String();
        updatedAt = DateTime.now().toIso8601String();
        notifyListeners();
      } else {
        status = 'Failed';
        notifyListeners();
        throw Exception('Failed to submit form');
      }
    }
  }
}

class MyForm extends StatelessWidget {
  String selectedOption = "Option default";

  MyForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF075995),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Technical Support',
          style: TextStyle(
              color: Color(0xff075995),
              fontStyle: FontStyle.normal,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: String.fromEnvironment("poppins")),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer(builder: (context, WidgetRef ref, child) {
            final form = ref.watch(formProvider);
            return Form(
              key: form.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Name',
                    style: TextStyle(
                        color: Color(0xff009BA6),
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: String.fromEnvironment("poppins")),
                  ),
                  const SizedBox(
                    height: 10, // <-- SEE HERE
                  ),
                  SizedBox(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'please enter your name here',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xff075995),
                            width: 5,
                          ))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        form.name = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25, // <-- SEE HERE
                  ),
                  const Text(
                    'Email',
                    style: TextStyle(
                        color: Color(0xff009BA6),
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: String.fromEnvironment("poppins")),
                  ),
                  const SizedBox(
                    height: 10, // <-- SEE HERE
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'please enter your email here',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff075995),
                          width: 5,
                        ))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(
                              r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      form.email = value;
                    },
                  ),
                  const SizedBox(
                    height: 25, // <-- SEE HERE
                  ),
                  const Text(
                    'Issue topic',
                    style: TextStyle(
                        color: Color(0xff009BA6),
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: String.fromEnvironment("poppins")),
                  ),
                  const SizedBox(
                    height: 10, // <-- SEE HERE
                  ),
                  DropdownButtonFormField(
                    isExpanded: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xff075995),
                        width: 5,
                      )),
                      labelText: '',
                    ),
                    value: selectedOption,
                    items: const [
                      DropdownMenuItem(
                        value: 'Incorrect billing or payment amount.',
                        child: Text(
                          'Incorrect billing or payment amount.',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: String.fromEnvironment("poppins")),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Broken hyperlink or payment.',
                        child: Text(
                          'Broken hyperlink or payment.',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: String.fromEnvironment("poppins")),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Login credentials not recognized or forgotten',
                        child: Text(
                          'Login credentials not recognized or forgotten',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: String.fromEnvironment("poppins")),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Slow website loading or server timeouts',
                        child: Text(
                          'Slow website loading or server timeouts',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: String.fromEnvironment("poppins")),
                        ),
                      ),
                      DropdownMenuItem(
                        value:
                            'Unable to access specific website features or functionality',
                        child: Text(
                          'Unable to access specific website features or functionality',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: String.fromEnvironment("poppins")),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Option default',
                        child: Text(
                          'Select the issue topic',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: String.fromEnvironment("poppins")),
                        ),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOption = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an issue type';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      form.issueTopic = value;
                    },
                  ),
                  const SizedBox(
                    height: 25, // <-- SEE HERE
                  ),
                  const Text(
                    'Issue description',
                    style: TextStyle(
                        color: Color(0xff009BA6),
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: String.fromEnvironment("poppins")),
                  ),
                  const SizedBox(
                    height: 10, // <-- SEE HERE
                  ),
                  SizedBox(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 60.0),
                          labelText: 'please tell us about your problem',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xff075995),
                            width: 5,
                          ))),
                      maxLines: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an issue description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        form.issueDescription = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        form.submitForm();
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen(
                                        yourName: 'moath asfour',
                                      )));
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
