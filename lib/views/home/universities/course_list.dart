import 'package:flutter/material.dart';

class CoursesList extends StatelessWidget {
  const CoursesList({Key? key}) : super(key: key);

  // create list of university courses from the list


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,

      itemBuilder: (context, i) {
      return ListTile(
        title: Text("Course $i"),
      );
    });
  }
}
