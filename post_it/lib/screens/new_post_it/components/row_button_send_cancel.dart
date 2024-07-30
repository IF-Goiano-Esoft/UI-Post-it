import 'package:flutter/material.dart';

class RowButtonSendCancel extends StatelessWidget {
  const RowButtonSendCancel({
    super.key,
    required DateTime? selectedDate,
    required GlobalKey<FormState> formKey,
  })  : _selectedDate = selectedDate,
        _formKey = formKey;

  final DateTime? _selectedDate;
  final GlobalKey<FormState> _formKey;

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
              Navigator.of(context).pop();
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
