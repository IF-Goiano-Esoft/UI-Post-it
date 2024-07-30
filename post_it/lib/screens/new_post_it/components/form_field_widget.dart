import 'package:flutter/material.dart';

class FormFieldWidget extends StatefulWidget {
  FormFieldWidget({
    super.key,
  });

  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  final _dateController = TextEditingController();

  String? _validarTitulo(String titulo) {
    if (titulo.length < 4) return 'O titulo necessita pelo menos 5 letras';
    return null;
  }

  String? _validarDescricao(String titulo) {
    if (titulo.length < 4) return 'A descrição necessita pelo menos 5 letras';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) => _validarTitulo(value!),
            decoration: const InputDecoration(
              icon: Icon(Icons.title),
              label: Text('Titulo'),
              hintText: 'Pergunta',
            ),
          ),
          const SizedBox(height: 25),
          TextFormField(
            validator: (value) => _validarDescricao(value!),
            decoration: const InputDecoration(
              icon: Icon(Icons.question_answer),
              label: Text('Descrição'),
              hintText: 'Resposta',
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.calendar_month,
                size: 29,
                color: Colors.grey.shade800,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
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
                                      ? "Data de Prazo: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                                      : 'Cliquei para selecionar a Data',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          Row(
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
                  if (_formKey.currentState!.validate() &&
                      _selectedDate != null) {
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.purple,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
