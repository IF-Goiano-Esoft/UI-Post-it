import 'dart:ui';

import 'package:post_it/core/models/post_it.dart';
import 'package:post_it/core/models/post_it_user.dart';
import 'package:post_it/core/services/post_it/post_it_mock_service.dart';

abstract class PostItService {
  Stream<List<PostIt>> postItsStream();
  Stream<List<PostIt>> postItsByUserStream(PostItUser user);

  Future<void> remove(PostIt post);

  Future<PostIt> save(
    String title,
    String description,
    DateTime date,
    Color color,
    PostItUser user,
  );

  factory PostItService() {
    return PostItMockService();
  }
}
