import 'package:flutter/material.dart';
import 'package:post_it/screens/new_post_it_screen/components/form_field_widget.dart';

class NewPostItScreen extends StatefulWidget {
  const NewPostItScreen({super.key});

  @override
  State<NewPostItScreen> createState() => _NewPostItScreenState();
}

class _NewPostItScreenState extends State<NewPostItScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Post-It'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: FormFieldWidget(),
      ),
    );
  }
}
