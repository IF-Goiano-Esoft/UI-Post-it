import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:post_it/core/models/post_it_user.dart';
import 'package:post_it/core/services/auth/auth_service.dart';

class AuthApiService implements AuthService {
  static PostItUser? _currentUser;
  static MultiStreamController<PostItUser?>? _controller;

  static final _userStream = Stream<PostItUser?>.multi((controller) {
    _controller = controller;
    _updateUser(null);
  });

  PostItUser? get currentUser {
    return _currentUser;
  }

  Stream<PostItUser?> get userChanges {
    return _userStream;
  }

  Future<void> signup(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/user/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final userId = jsonDecode(response.body)['id'];
      final newUser = PostItUser(id: userId, name: name, email: email);
      _updateUser(newUser);
    } else {
      // Handle errors (e.g., user already exists, etc.)
      print('Erro');
    }
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/user/auth'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final userId = jsonDecode(response.body)['id'];
      final user = PostItUser(id: userId, name: '', email: email);
      _updateUser(user);
    } else {
      // Handle errors (e.g., invalid credentials, etc.)
    }
  }

  Future<void> logout() async {
    _updateUser(null);
  }

  static void _updateUser(PostItUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
