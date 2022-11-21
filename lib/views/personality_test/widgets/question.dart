import 'package:course_guide/views/personality_test/widgets/circles.dart';
import 'package:flutter/material.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({Key? key, required this.question, required this.index})
      : super(key: key);
  final String question;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              question,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Circles(),
          ),
        ],
      ),
    );
  }
}
