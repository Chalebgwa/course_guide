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
        title: Text('MBTI Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Question ${mbtiProvider.currentQuestionIndex}:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  question["Q${mbtiProvider.currentQuestionIndex}"],
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 32),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (MapEntry q in question['answers'].entries)
                  ElevatedButton(
                    onPressed: () {
                      mbtiProvider.updateAnswer(
                        q.key,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      //primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      q.value,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
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
