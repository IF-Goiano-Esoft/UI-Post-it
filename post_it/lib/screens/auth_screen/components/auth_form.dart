import 'package:flutter/material.dart';
import 'package:post_it/core/models/auth_form_data.dart';

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
                    final name = _name ?? '';
                    if (name.trim().length < 5) {
                      return 'O nome precisa conter pelo menos 5 letras';
                    }
                    return null;
                  },
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _authData.email,
                onChanged: (email) => _authData.email = email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (_email) {
                  final email = _email ?? '';
                  if (!email.contains('@')) {
                    return 'O email digitado não é valido';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _authData.password,
                onChanged: (password) => _authData.password = password,
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.length < 6) {
                    return 'A senha precisa ter pelo menos 6 caracteres';
                  }
                  return null;
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
