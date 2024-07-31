import 'package:flutter/material.dart';

class PostIt {
  final String title;
  final String description;
  final DateTime date;
  final Color color;

  PostIt({
    required this.title,
    required this.description,
    required this.date,
    this.color = const Color(0xfffFEB3B),
  });
}
