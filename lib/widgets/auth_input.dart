import 'package:flutter/material.dart';
import 'package:lab5/utils/utils.dart';

class AuthInput extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final void Function(String) callback;
  final bool isPassword;
  const AuthInput(
      {super.key,
      required this.controller,
      required this.text,
      required this.callback,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        callback(value ?? '');
        return null;
      },
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primeColor, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(9)),
        ),
        hintText: text,
        hintStyle: const TextStyle(fontSize: 19),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 19, horizontal: 15),
      ),
    );
  }
}
