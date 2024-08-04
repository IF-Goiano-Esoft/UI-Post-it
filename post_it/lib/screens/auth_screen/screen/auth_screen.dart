import 'package:flutter/material.dart';
import 'package:post_it/core/models/auth_form_data.dart';
import 'package:post_it/core/services/auth/auth_mock_service.dart';
import 'package:post_it/screens/auth_screen/components/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;

  void _handleSubmit(AuthFormData formData) async {
    try {
      if (formData.isLogin) {
        // Login
        await AuthMockService().login(
          formData.email,
          formData.password,
        );
      } else {
        // Cadastro
        AuthMockService().signup(
          formData.name,
          formData.email,
          formData.password,
        );
      }
    } catch (error) {
      // Tratar Erro
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(
                onSubmit: _handleSubmit,
              ),
            ),
          ),
          if (_isLoading)
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
