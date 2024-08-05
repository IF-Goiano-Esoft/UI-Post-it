import 'dart:math';

import 'package:flutter/material.dart';
import 'package:post_it/core/models/post_it_user.dart';

class PostIt {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final Color color;
  final PostItUser user;
  

  PostIt({
    String? id,
    required this.title,
    required this.description,
    required this.date,
    required this.color,
    this.user = const PostItUser(id: '01', name: 'Arthur', email: 'a@a.com'),
  }) : id = id ?? Random().nextDouble().toString();
}
