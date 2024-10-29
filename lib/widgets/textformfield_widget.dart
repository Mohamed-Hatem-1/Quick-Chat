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
      },
      onChanged: onChanged,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
