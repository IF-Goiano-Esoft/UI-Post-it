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
    required this.user,
  }) : id = id ?? Random().nextDouble().toString();

  factory PostIt.fromJson(Map<String, dynamic> json) {
    return PostIt(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      color: json['color'],
      user: PostItUser.fromJson(json['user']), // Supondo que PostItUser também tenha um método fromJson
    );
  }

  // Método toJson se precisar converter o objeto de volta para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'color': color,
      'user': user.toJson(),
    };
  }
}
