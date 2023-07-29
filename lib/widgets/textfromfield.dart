import 'package:flutter/material.dart';

class TFromField extends StatelessWidget {
  final String hinttext;
  final String labelText;
  final Icon icon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const TFromField(
      {super.key,
      required this.hinttext,
      required this.icon,
      required this.labelText,
      required this.controller,
      this.validator});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hinttext,
          labelText: labelText,
          prefixIcon: icon,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}
