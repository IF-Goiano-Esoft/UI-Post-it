import 'package:flutter/material.dart';
import 'package:post_it/core/models/post_it_user.dart';
import 'package:post_it/core/services/auth/auth_mock_service.dart';
import 'package:post_it/screens/auth_screen/screen/auth_screen.dart';
import 'package:post_it/screens/loading_screen/loading_screen.dart';
import 'package:post_it/screens/post_it_screen/screen/post_it_screen.dart';

class AuthOrAppScreen extends StatelessWidget {
  const AuthOrAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: StreamBuilder<PostItUser?>(
        stream: AuthMockService().userChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          } else {
            return snapshot.hasData ? PostItScreen() : AuthScreen();
          }
        },
      ),
    );
  }
}
