import 'package:flutter/material.dart';
import 'package:post_it/core/services/auth/auth_service.dart';
import 'package:post_it/screens/new_post_it_screen/components/row_button_send_cancel.dart';
import 'package:post_it/screens/new_post_it_screen/validators/description_validator.dart';
import 'package:post_it/screens/new_post_it_screen/validators/title_validator.dart';
import 'IconData.dart';

class FormFieldWidget extends StatefulWidget {
  const FormFieldWidget({
    super.key,
  });

  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  final _dateController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final Map<String, Color> listColor = {
    'Amarelo': const Color(0xffFFEB3B),
    'Verde': const Color(0xff69F0AE),
    'Azul': const Color(0xff448AFF),
    'Vermelho': const Color(0xffFF5252),
    'Rosa': const Color(0xffFE9FBB),
  };
  String selectedColor = 'Amarelo';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Text Field Titulo
            TextFormField(
              controller: _titleController,
              validator: (value) => titleValidator(value),
              decoration: const InputDecoration(
                icon: Icon(Icons.title),
                label: Text('Titulo'),
                hintText: 'Pergunta',
              ),
            ),
            const SizedBox(height: 25),

            // Text Field Description
            TextFormField(
              controller: _descriptionController,
              validator: (value) => descriptionValidator(value),
              decoration: const InputDecoration(
                icon: Icon(Icons.question_answer),
                label: Text('Descrição'),
                hintText: 'Resposta',
              ),
            ),
            const SizedBox(height: 25),

            // Selecionar Data
            Row(
              children: [
                const SizedBox(
                  width: 150,
                  child: IconSelectData(),
                ),
                DatePicker(context),
              ],
            ),
            const SizedBox(height: 25),

            // Dropdown escolha de Cores
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.color_lens_outlined,
                      size: 29,
                      color: Colors.grey.shade800,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Escolha a cor do Post It: ',
                      style:
                          TextStyle(color: Color.fromARGB(255, 109, 109, 109)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    value: selectedColor,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                    items: listColor.keys
                        .map<DropdownMenuItem<String>>((nameColor) {
                      return DropdownMenuItem(
                        value: nameColor,
                        child: Text(nameColor),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedColor = value!;
                      });
                    },
                  ),
                ),
              ],
            ),

            // Botões para enviar e cancelar
            RowButtonSendCancel(
              selectedDate: _selectedDate,
              selectedColor: listColor[selectedColor],
              formKey: _formKey,
              titleController: _titleController,
              descriptionController: _descriptionController,
              onPostItAdded: (postIt) {
                Navigator.of(context).pop(postIt);
              },
              user: AuthService().currentUser!,
            ),
          ],
        ),
      ),
    );
  }

  Padding DatePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2050),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                      _dateController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      Text(
                        _selectedDate != null
                            ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                            : 'Selecionar a Data',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
