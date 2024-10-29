import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  Color? c,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: c == null ? Colors.red : Colors.green,
    ),
  );
}
