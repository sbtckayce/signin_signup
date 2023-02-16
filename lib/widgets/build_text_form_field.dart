import 'package:flutter/material.dart';

class BuildTextFormField extends StatelessWidget {
  const BuildTextFormField(
      {super.key,
      required this.hintText,
      this.obscureText = false,
      required this.controller});
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          
          filled: true,
          fillColor: Color(0xFF95afc0),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 2,color: Colors.blue
              ))),
    );
  }
}
