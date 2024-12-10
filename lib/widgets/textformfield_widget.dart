import 'package:flutter/material.dart';

class TextformfieldWidget extends StatelessWidget {
  final String? hint;
  Function(String)? onChanged;
  bool obsecureText;
  TextformfieldWidget(
      {super.key,
      required this.hint,
      required this.onChanged,
      this.obsecureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText,
      validator: (value) {
        if (value!.isEmpty) return 'Field is Required';
        return null;
      },
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
