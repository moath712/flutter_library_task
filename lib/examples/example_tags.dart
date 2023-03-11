import 'package:flutter/material.dart';
import 'package:flutter_library_task/examples/library1.dart';
import 'package:flutter_library_task/examples/library2.dart';
import 'package:flutter_library_task/examples/library3.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Define a Provider to fetch the tags from the API
final tagsProvider = FutureProvider<List<Tags>>((ref) async {
  final response = await http
      .get(Uri.parse('https://development.himam.com/api/library/tags'));
  if (response.statusCode == 200) {
    final tagsJson = jsonDecode(response.body) as List<dynamic>;
    return tagsJson.map((json) => Tags.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch tags');
  }
});

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

class TagBar extends StatelessWidget {
  const TagBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, WidgetRef ref, _) {
      final tagsAsyncValue = ref.watch(tagsProvider);
      return tagsAsyncValue.when(
        data: (tags) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tags.map((tag) {
              return GestureDetector(
                onTap: () {
                  if (tag.id == 1) {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const library1()),
                    );
                  } else if (tag.id == 2) {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const library2()),
                    );
                  } else if (tag.id == 3) {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const library3()),
                    );
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(color: Color(0xff009BA6), spreadRadius: 1.0)
                      ]),
                  child: Text(
                    tag.name,
                    style: const TextStyle(color: Color(0xff009BA6)),
                  ),
                ),
              );
            }).toList(),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text('Error: $error'),
      );
    });
  }
}

class TagDetails extends StatelessWidget {
  final Tags tag;

  const TagDetails({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tag.name),
      ),
      body: Center(
        child: Text('Details for tag ${tag.name}'),
      ),
    );
  }
}
