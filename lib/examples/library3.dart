import 'package:flutter/material.dart';
import 'package:flutter_library_task/models/library_class.dart';
import 'package:flutter_library_task/screens/library_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

final himamApiProvider = FutureProvider<List<HimamApi>>((ref) async {
  final response =
      await http.get(Uri.parse('https://development.himam.com/api/library'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    final List<HimamApi> himamApiList =
        data.map((e) => HimamApi.fromJson(e)).toList();

    return himamApiList.where((element) => element.tagId == 3).toList();
  } else {
    throw Exception('Failed to load data');
  }
});

class library3 extends StatelessWidget {
  const library3({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
    return Consumer(
      builder: (context, WidgetRef ref, child) {
        final himamApiList = ref.watch(himamApiProvider);
        return himamApiList.when(
          data: (data) => ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final himamApi = data[index];
              final Uri _url = Uri.parse(himamApi.media?.url ?? '');
              Future<void> _launchUrl() async {
                if (!await launchUrl(_url)) {
                  throw Exception('Could not launch $_url');
                }
              }

              return InkWell(
                onTap: _launchUrl,
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/pdf.png',
                  ),
                  title: Text(himamApi.media?.fileName ?? ''),
                  subtitle: Text(himamApi.createdAt ?? ''),
                ),
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
