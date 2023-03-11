import 'package:flutter_library_task/Http_requests/tags_request.dart';
import 'package:flutter_library_task/models/tag_class.dart';
import 'package:riverpod/riverpod.dart';

final tagsFutureProvider = FutureProvider<List<Tag>>((ref) async {
  return await TagService.getTags();
});
