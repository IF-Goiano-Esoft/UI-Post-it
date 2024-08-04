import 'package:flutter/material.dart';
import 'package:post_it/data/post_it_list.dart';
import 'package:post_it/core/models/post_it.dart';

class RowButtonSendCancel extends StatelessWidget {
  final DateTime? _selectedDate;
  final Color? _selectedColor;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _titleController;
  final TextEditingController _descriptionController;
  final Function(PostIt) onPostItAdded;

  RowButtonSendCancel({
    super.key,
    required DateTime? selectedDate,
    required Color? selectedColor,
    required GlobalKey<FormState> formKey,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required this.onPostItAdded,
  })  : _selectedDate = selectedDate,
        _selectedColor = selectedColor,
        _formKey = formKey,
        _titleController = titleController,
        _descriptionController = descriptionController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        const Expanded(child: SizedBox()),
        IconButton(
          onPressed: () {
            if (_selectedDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Selecione uma Data Valida'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }
            if (_formKey.currentState!.validate()) {
              PostIt newPostIt = PostIt(
                title: _titleController.text,
                description: _descriptionController.text,
                date: _selectedDate,
                color: _selectedColor!,
              );
              PostItList.addPostIt(newPostIt);
              onPostItAdded(newPostIt);
            }
          },
          icon: const Icon(
            Icons.send,
            color: Colors.purple,
          ),
        )
      ],
    );
  }
}
