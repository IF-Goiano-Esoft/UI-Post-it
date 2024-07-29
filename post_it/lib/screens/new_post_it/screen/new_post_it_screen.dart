import 'package:flutter/material.dart';

class NewPostItScreen extends StatelessWidget {
  const NewPostItScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Post-It'),
      ),
      body: Center(
        child: Text('Formulario'),
      ),
    );
  }
}
