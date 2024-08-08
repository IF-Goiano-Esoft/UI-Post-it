import 'dart:async';
import 'dart:math';
import 'package:post_it/core/models/post_it_user.dart';
import 'package:post_it/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static Map<String, PostItUser> _users = {};
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
    final newUser = PostItUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  Future<void> logout() async {
    _updateUser(null);
  }

  static void _updateUser(PostItUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
