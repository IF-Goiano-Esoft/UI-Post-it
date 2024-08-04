import 'dart:math';

import 'package:flutter/material.dart';

class PostIt {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final Color color;

  PostIt({
    String? id,
    required this.title,
    required this.description,
    required this.date,
    this.color = const Color(0xfffFEB3B),
  }) : id = id ?? Random().nextDouble().toString();
}
