import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTextField extends StatelessWidget {
//Il est utilisé pour les champs de texte avec les labels, les couleurs et les icônes

  final TextEditingController controller;
  final String label;
  const CustomTextField(
      {super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(12.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(12.0)),
            label: Text(
              label.toString(),
              style: const TextStyle(color: Colors.orange),
            ),
            border: InputBorder.none),
        style: const TextStyle(fontWeight: FontWeight.bold),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2040));

          if (pickedDate != null) {
            controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
          }
        },
      ),
    );
  }
}
