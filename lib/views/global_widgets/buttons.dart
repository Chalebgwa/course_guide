import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, tertiary }

class Button extends StatelessWidget {
  const Button(
      {Key? key, required this.text, this.onPressed, required this.buttonType})
      : super(key: key);

  final String text;
  final Function()? onPressed;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.primary:
        return ElevatedButton(
          onPressed: onPressed,
          child: Text(text),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );

      case ButtonType.secondary:
        return OutlinedButton(
          onPressed: onPressed,
          child: Text(text),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      default:
        return Container();
    }
  }
}
