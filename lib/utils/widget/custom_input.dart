import 'package:flutter/material.dart';
import 'package:mau_masak/theme/styles.dart';

class CustomInput extends StatelessWidget {
  final Widget? prefixicon;
  final bool obsecureText;
  final String label;

  const CustomInput({
    Key? key,
    this.prefixicon,
    required this.obsecureText,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
        prefixIcon: prefixicon,
        hintText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: primaryColor),
        ),
      ),
    );
  }
}
