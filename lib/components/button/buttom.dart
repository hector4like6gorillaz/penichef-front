import 'package:base_app/utils/constans.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.fn,
    this.text = "Vacio",
  });
  final Function fn;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      disabledColor: Colors.grey,
      onPressed: () {
        fn();
      },
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(text),
    );
  }
}
