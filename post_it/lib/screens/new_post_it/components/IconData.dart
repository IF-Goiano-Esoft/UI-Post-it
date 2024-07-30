import 'package:flutter/material.dart';

class IconSelectData extends StatelessWidget {
  const IconSelectData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.calendar_month,
          size: 29,
          color: Colors.grey.shade800,
        ),
        const SizedBox(width: 8),
        const Text(
          'Data de prazo:',
          style: TextStyle(
            color: Color.fromARGB(255, 124, 124, 124),
          ),
        ),
      ],
    );
  }
}
