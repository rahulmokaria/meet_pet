import 'package:flutter/material.dart';

import '../utils/colors.dart';

TextFormField textFieldUi(String text, IconData icon, bool isPasswordType,
    TextEditingController controller, TextInputType inputType) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    cursorColor: primary,
    keyboardType: inputType,
    style: TextStyle(color: primary),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: primary,
      ),
      labelText: text,
      labelStyle: TextStyle(color: primary),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: secondaryLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
  );
}
