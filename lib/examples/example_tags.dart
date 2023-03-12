import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_library_task/examples/library1.dart';
import 'package:flutter_library_task/examples/library2.dart';
import 'package:flutter_library_task/examples/library3.dart';

import 'package:http/http.dart' as http;

class TagBar extends StatefulWidget {
  @override
  _TagBarState createState() => _TagBarState();
}

class _TagBarState extends State<TagBar> {
  List<Tags>? _tags;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchTags();
  }

  Future<void> _fetchTags() async {
    final response = await http
        .get(Uri.parse('https://development.himam.com/api/library/tags'));

    if (response.statusCode == 200) {
      final tagsJson = json.decode(response.body) as List<dynamic>;
      final tags = tagsJson.map((json) => Tags.fromJson(json)).toList();
      setState(() {
        _tags = tags;
      });
    } else {
      throw Exception('Failed to fetch tags');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_tags == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              final tag = _tags![index];
              final isSelected = index == _selectedIndex;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff009BA6),
                          width: 1.0,
                          style: BorderStyle.solid),
                      color: isSelected ? Color(0xff009BA6) : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: []),
                  child: Center(
                    child: Text(
                      tag.name,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Color(0xff009BA6),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        if (_selectedIndex < _tags!.length)
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(height: 800.0, child: library3()),
              ),
            ],
          ),
      ],
    );
  }
}

class Tags {
  final int id;
  final String name;

  Tags({required this.id, required this.name});

  factory Tags.fromJson(Map<String, dynamic> json) {
    return Tags(
      id: json['id'],
      name: json['name'],
    );
  }
}
