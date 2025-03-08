import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String message, [
  Color color = Colors.red,
]) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
}
