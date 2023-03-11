import 'package:flutter/material.dart';
import 'package:flutter_library_task/screens/home_screen.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  String selectedOption = "Option default";

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
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Name',
                    style: TextStyle(
                        color: Color(0xff009BA6),
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: String.fromEnvironment("poppins")),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Please enter your name here',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Email',
                    style: TextStyle(
                        color: Color(0xff009BA6),
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: String.fromEnvironment("poppins")),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Please enter your email here',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Issue Topic',
                    style: TextStyle(
                        color: Color(0xff009BA6),
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: String.fromEnvironment("poppins")),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField(
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Issue Type',
                  ),
                  value: selectedOption,
                  items: const [
                    DropdownMenuItem(
                      value: 'Option 1',
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
                      value: 'Option 2',
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
                      value: 'Option 3',
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
                      value: 'Option 4',
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
                      value: 'Option 5',
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
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(bottom: 1),
                  child: Text(
                    'Issue Description',
                    style: TextStyle(
                        color: Color(0xff009BA6),
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: String.fromEnvironment("poppins")),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'please enter your email here',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description of the issue';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Submit form
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                      yourName: 'ss',
                                    )));
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
