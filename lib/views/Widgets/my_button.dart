import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Color color;
  final void Function()? onPressed;

  MyButton({required this.title, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color(0xFFA31621),
              //color: Color.fromARGB(255, 129, 22, 14),
              borderRadius: BorderRadius.circular(12)
          ),
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),
              )

              ),
            ),
        ),
      ),

    );
  }
}
