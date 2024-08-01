import 'package:flutter/material.dart';

SnackBar buildSuccessSnackBar(String text, Color color) {
  return SnackBar(
    content: Text(text),
    backgroundColor: color,
  );
}
