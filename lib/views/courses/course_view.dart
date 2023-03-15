import 'package:course_guide/models/course.dart';
import 'package:flutter/material.dart';

class CourseView extends StatelessWidget {
  const CourseView({Key? key, required this.course}) : super(key: key);
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {},
          label: Text(
            "Apply",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(course.title ?? ""),
                background: course.imageUrl != null
                    ? Image.network(
                        course.imageUrl!,
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            if (course.description != null)
              SliverToBoxAdapter(
                child: Text(
                  course.description!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              )
          ],
        ));
  }
}
