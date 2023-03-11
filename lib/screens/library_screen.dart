import 'package:flutter/material.dart';
import 'package:flutter_library_task/screens/technical_form_screen.dart';
import '../examples/example_tags.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Library',
          style: TextStyle(
              color: Color(0xff075995),
              fontStyle: FontStyle.normal,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: String.fromEnvironment("poppins")),
        ),
        actions: [
          IconButton(
            color: const Color(0xff075995),
            icon: const Icon(Icons.support_agent),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyForm()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ClickedTagBar(),
        ],
      ),
    );
  }
}
