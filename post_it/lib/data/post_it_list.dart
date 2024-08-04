import 'package:post_it/core/models/post_it.dart';

class PostItList {
  static final List<PostIt> _postIts = [];

  static List<PostIt> get postIts => _postIts;

  static void addPostIt(PostIt postIt) {
    _postIts.add(postIt);
  }
}
