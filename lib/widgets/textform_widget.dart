import 'package:flutter/material.dart';

class Textform extends StatelessWidget {
  Textform({
    Key? key,
    required this.controller,
    required this.text,
    required this.textInputType,
    required this.obscure,
    required this.onchange,
  }) : super(key: key);
  TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final bool obscure;
  final void Function(String) onchange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: controller,
            keyboardType: textInputType,
            obscureText: obscure,
            cursorColor: const Color(0xFF71ae87),
            onChanged: onchange,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
            ),
          ),
        ),
      ),
    );
  }
}
