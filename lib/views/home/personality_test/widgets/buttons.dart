import 'package:flutter/material.dart';

class TestButtons extends StatelessWidget {
  const TestButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [

        ],
      ),
    );
  }

  Widget button(String text) {
    return Container(
      child: Text(text),
    );
  }
}