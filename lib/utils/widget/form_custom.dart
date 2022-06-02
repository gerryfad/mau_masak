import 'package:flutter/material.dart';
import 'package:mau_masak/theme/styles.dart';

class FormInputCustom {
  static InputDecoration inputDecor(
      {String labelTextStr = "",
      String hintTextStr = "",
      Widget? prefixicon,
      bool? obsecureText}) {
    return InputDecoration(
      labelText: labelTextStr,
      hintText: hintTextStr,
      contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
      prefixIcon: prefixicon,
      filled: true,
      focusColor: primaryColor,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: const BorderSide(color: primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: const BorderSide(color: primaryColor),
      ),
    );
  }
}
