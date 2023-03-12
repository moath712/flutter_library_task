import 'package:flutter/material.dart';
import 'package:flutter_library_task/models/library_class.dart';
import 'package:flutter_library_task/screens/library_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final himamApiProvider = FutureProvider<List<HimamApi>>((ref) async {
  final response =
      await http.get(Uri.parse('https://development.himam.com/api/library'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    final List<HimamApi> himamApiList =
        data.map((e) => HimamApi.fromJson(e)).toList();

    return himamApiList.where((element) => element.tagId == 1).toList();
  } else {
    throw Exception('Failed to load data');
  }
});

class library1 extends StatelessWidget {
  const library1({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, WidgetRef ref, child) {
        final himamApiList = ref.watch(himamApiProvider);
        return himamApiList.when(
          data: (data) => ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final himamApi = data[index];
              return ListTile(
                leading: Image.asset(
                  'assets/images/pdf.png',
                ),
                title: Text(himamApi.media?.fileName ?? ''),
                subtitle: Text(himamApi.createdAt ?? ''),
              );
            },
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => const Text('Failed to load data'),
        );
      },
    );
  }
}
