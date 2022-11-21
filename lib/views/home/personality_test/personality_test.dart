import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/views/personality_test/widgets/circles.dart';
import 'package:course_guide/views/personality_test/widgets/question.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalityTest extends StatelessWidget {
  const PersonalityTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream:
          FirebaseFirestore.instance.collection('personality_test').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return QuestionView(
                question: snapshot.data!.docs[index]['question'],
                index: 0,
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
