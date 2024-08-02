import 'package:flutter/material.dart';
import 'package:post_it/screens/auth_screen/screen/auth_screen.dart';
import 'package:post_it/screens/post_it_screen/screen/post_it_screen.dart';
import 'package:post_it/screens/new_post_it/screen/new_post_it_screen.dart';
import 'package:post_it/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post-It',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          color: Colors.purple.shade500,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        primaryColor: Colors.purple,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.purple,
            ),
      ),
      routes: {
        AppRoutes.HOME: (ctx) => const AuthScreen(),
        AppRoutes.POST_IT: (ctx) => const PostItScreen(),
        AppRoutes.NEW_POST_IT: (ctx) => const NewPostItScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
