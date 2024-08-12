import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_it/core/models/post_it.dart';
import 'package:post_it/core/models/post_it_user.dart';
import 'package:post_it/core/services/post_it/post_it_service.dart';

class PostItApiService implements PostItService {
  static MultiStreamController<List<PostIt>>? _controller;
  static List<PostIt> _postIts = [];

  static final _postItsStream = Stream<List<PostIt>>.multi((controller) {
    _controller = controller;
    _fetchPostIts(); // Função para buscar todos os Post-Its de um usuário
  });

  static Future<void> _fetchPostIts() async {
    // Aqui você pode definir o ID do usuário para buscar os Post-Its específicos desse usuário
    final userId = 'id_do_usuario_aqui';
    final response = await http
        .get(Uri.parse('https://localhost:8080/notes/getall/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      _postIts = data.map((item) => PostIt.fromJson(item)).toList();
      _controller?.add(_postIts);
    } else {
      // Tratar erros
    }
  }

  Stream<List<PostIt>> postItsStream() {
    return _postItsStream;
  }

  Future<void> remove(PostIt post) async {
    final response = await http.delete(
      Uri.parse('https://localhost:8080/notes/delete/${post.id}'),
    );

    if (response.statusCode == 200) {
      _postIts.remove(post);
      _controller?.add(_postIts);
    } else {
      // Tratar erros
    }
  }

  Future<PostIt> save(
    String title,
    String description,
    DateTime date,
    Color color,
    PostItUser user,
  ) async {
    final response = await http.post(
      Uri.parse('https://localhost:8080/notes/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'description': description,
        'date': date.toIso8601String(),
        'color':
            '#${color.value.toRadixString(16).substring(2)}', // Armazena a cor como string hexadecimal
        'user_id': user.id,
      }),
    );

    if (response.statusCode == 200) {
      final newPostIt = PostIt.fromJson(jsonDecode(response.body));
      _postIts.add(newPostIt);
      _controller?.add(_postIts);
      return newPostIt;
    } else {
      // Tratar erros
      throw Exception('Falha ao criar o PostIt');
    }
  }

  Stream<List<PostIt>> postItsByUserStream(PostItUser user) {
    return _postItsStream.map(
      (postIts) =>
          postIts.where((postIt) => postIt.user.id == user.id).toList(),
    );
  }
}
