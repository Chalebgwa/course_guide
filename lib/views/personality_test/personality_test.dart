import 'package:course_guide/controllers/mbti_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalityTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mbtiProvider = Provider.of<MBTIController>(context);
    final question = mbtiProvider.currentQuestion;

    return Scaffold(
      appBar: AppBar(
        title: Text('MBTI Quiz d'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Question ${question.questionNumber}:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              question.questionText,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    mbtiProvider.updateAnswer(question.optionA);
                  },
                  child: Text(question.optionA),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    mbtiProvider.updateAnswer(question.optionB);
                  },
                  child: Text(question.optionB),
                ),
              ],
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                mbtiProvider.calculatePersonalityType();
              },
              child: Text('Calculate Result'),
            ),
            SizedBox(height: 16),
            Text(
              'Personality Type: ${mbtiProvider.personalityType}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}