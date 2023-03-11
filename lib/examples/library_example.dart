import 'package:flutter/material.dart';
import 'package:flutter_library_task/Http_requests/library_request.dart';

import 'package:provider/provider.dart';

import '../models/library_class.dart';

class LibraryList extends StatelessWidget {
  const LibraryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Library List'),
      ),
      body: FutureProvider<List<HimamApi>>(
        create: (_) => ApiService().fetchLibrary(),
        initialData: const [],
        child: Consumer<List<HimamApi>>(
          builder: (_, libraryList, __) {
            if (libraryList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: libraryList.length,
              itemBuilder: (_, index) {
                final himamApi = libraryList[index];
                final fileName = himamApi.media?.fileName ?? 'N/A';

                return ListTile(
                  title: Text(fileName),
                  subtitle: Text(himamApi.createdAt ?? 'N/A'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
