import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class TextfieldPassword extends StatelessWidget {
  final controller; // Lets us access what the user typed into the text field
  final String hintText;
  final bool obscureText;
  final Icon icon;

  const TextfieldPassword(
    {super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: Material(
        child: Center(
          child: TextFormField(
            controller: controller,
            autocorrect: true,
            obscureText: obscureText,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[500]),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                prefixIcon: icon),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => 
              value != null && value.length < 6
                ? 'Enter min. 6 characters'
                : null,
          ),
        ),
      ),
    );
  }
}
