import 'dart:async';

import 'package:flutter/material.dart';
import 'package:post_it/core/models/post_it.dart';
import 'package:post_it/core/models/post_it_user.dart';
import 'package:post_it/core/services/post_it/post_it_service.dart';

class PostItMockService implements PostItService {
  static final List<PostIt> _postIts = [];
  static MultiStreamController<List<PostIt>>? _controller;

  static final _postItsStream = Stream<List<PostIt>>.multi((controller) {
    _controller = controller;
    controller.add(_postIts);
  });

  Stream<List<PostIt>> postItsStream() {
    return _postItsStream;
  }

  Future<void> remove(PostIt post) async {
    _postIts.remove(post);
    _controller?.add(_postIts);
  }

  Future<PostIt> save(
    String title,
    String description,
    DateTime date,
    Color color,
    PostItUser user,
  ) async {
    final newPostIt = PostIt(
      title: title,
      description: description,
      date: date,
      color: color,
      user: user,
    );

    _postIts.add(newPostIt);

    _controller?.add(_postIts);
    return newPostIt;
  }

  Stream<List<PostIt>> postItsByUserStream(PostItUser user) {
    return _postItsStream.map(
      (postIts) =>
          postIts.where((postIt) => postIt.user.id == user.id).toList(),
    );
  }
}
