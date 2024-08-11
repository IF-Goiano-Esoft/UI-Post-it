import 'package:flutter/material.dart';
import 'package:post_it/core/models/auth_form_data.dart';
import 'package:post_it/screens/auth_screen/validators/email_validator.dart';
import 'package:post_it/screens/auth_screen/validators/name_validator.dart';
import 'package:post_it/screens/auth_screen/validators/password_validator.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authData = AuthFormData();
  bool _isHiddenPassword = true;

  void _togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    widget.onSubmit(_authData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_authData.isSignup)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _authData.name,
                  onChanged: (name) => _authData.name = name,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (_name) {
                    return nameValidator(_name);
                  },
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _authData.email,
                onChanged: (email) => _authData.email = email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (_email) {
                  return emailValidator(_email);
                },
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _authData.password,
                onChanged: (password) => _authData.password = password,
                validator: (_password) {
                  return passwordValidator(_password);
                },
                obscureText: _isHiddenPassword,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isHiddenPassword
                          ? (Icons.visibility)
                          : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordView,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _authData.isLogin ? 'Entrar!' : 'Cadastrar!',
                ),
              ),
              TextButton(
                child: Text(
                  _authData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui conta?',
                ),
                onPressed: () {
                  setState(() {
                    _authData.toggleAuthMode();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
