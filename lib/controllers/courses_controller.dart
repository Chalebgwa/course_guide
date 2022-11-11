import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/models/course.dart';
import 'package:flutter/material.dart';

class CourseController extends ChangeNotifier {
  final List<Course> courses = [];
  final List<Course> filteredCourses = [];

  StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<Course>>
      get streamTransformer {
          return StreamTransformer.fromHandlers(
              handleData: (QuerySnapshot<Map<String, dynamic>> snapshot, sink) {
                  courses.clear();
                  snapshot.docs.forEach((doc) {
                      courses.add(Course.fromJson(doc.data()));
                  });
                  sink.add(courses);
              }
          );
        }

  void filterCourses(String category) {
    filteredCourses.clear();
    for (var course in courses) {
      if (course.category.contains(category)) {
        filteredCourses.add(course);
      }
    }
  }

  void addCourse(Course course) {
    courses.add(course);
  }

  void removeCourse(Course course) {
    courses.remove(course);
  }

  void updateCourse(Course course) {
    final index = courses.indexWhere((element) => element.id == course.id);
    courses[index] = course;
  }

  void clearCourses() {
    courses.clear();
  }

  void clearFilteredCourses() {
    filteredCourses.clear();
  }

  List<Course> get allCourses => courses;

  //stream courses from firebase and add to courses list
  Stream<List<Course>> get streamCourses {
    // get courses from firebase
    final Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        FirebaseFirestore.instance.collection('courses').snapshots();

    // transform stream

    return stream.transform(streamTransformer);
  }
}
