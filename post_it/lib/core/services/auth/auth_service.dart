import 'package:post_it/core/models/post_it_user.dart';

abstract class AuthService {
  PostItUser? get currentUser;

  Stream<PostItUser?> get userChanges;

  Future<void> signup(
    String name,
    String email,
    String password,
  );

  Future<void> login(
    String email,
    String password,
  );

  Future<void> logout();
}
