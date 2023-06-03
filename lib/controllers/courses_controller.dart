import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/controllers/auth.dart';
import 'package:course_guide/models/course.dart';
import 'package:flutter/material.dart';

class CourseController extends ChangeNotifier {
  final Auth auth;
  final List<Course> courses = [];
  final List<Course> filteredCourses = [];
  bool showFilter = true;

  Map<String,dynamic> results = {};

  toggleFilter() {
    showFilter = !showFilter;
    // persist filter state

    notifyListeners();
  }

  CourseController(this.auth){
    fetchResults();
  }

  // fetch results from firebase using the user's id
  Future<void> fetchResults() async {
    try {
      if (auth.currentUser?.uid != null) {
        final doc = await FirebaseFirestore.instance
            .collection("users")
            .doc(auth.currentUser!.uid)
            .get();

        if(doc.exists) {
          results = doc.data()?["result"];
        }
      }
    } catch (e) {
      print(e);
    }
  }

  // update results in firebase
  Future<void> updateResults(Map<String, dynamic> results) async {
    try {
      if (auth.currentUser?.uid != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(auth.currentUser!.uid)
            .set({"result": results}, SetOptions(merge: true));

        fetchResults();
      }
    } catch (e) {
      print(e);
    }
  }

  StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<Course>>
      get streamTransformer {
    return StreamTransformer.fromHandlers(
        handleData: (QuerySnapshot<Map<String, dynamic>> snapshot, sink) {
      courses.clear();
      snapshot.docs.forEach((doc) {
        print(doc.reference.path);
        final uniId = doc.reference.parent.parent?.id;
        final id = doc.reference.id;

        courses.add(
            Course.fromJson(doc.data()..addAll({"uniId": uniId, "id": id})));
      });
      sink.add(courses);
    });
  }

  void filterCourses(String category) {
    filteredCourses.clear();
    for (var course in courses) {
      if (course.category != null && course.category!.contains(category)) {
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
  Stream<List<Course>> streamCourses(String? category) {
    // get courses from firebase
    late Stream<QuerySnapshot<Map<String, dynamic>>> stream;

    try {
      if (category == null) {
        if (showFilter) {
          stream = FirebaseFirestore.instance
              .collectionGroup("courses")
              .where(
                "requiredSubjects",
                arrayContainsAny: auth.currentUser?.results?.keys.toList(),
              )
              .where("minimumPoints",
                  isGreaterThanOrEqualTo: auth.currentUser?.results?["points"])
              .where("featured", isEqualTo: "true")
              .snapshots();
        } else {
          stream =
              FirebaseFirestore.instance.collectionGroup("courses").snapshots();
        }
      } else {
        if (showFilter) {
          stream = FirebaseFirestore.instance
              .collectionGroup('courses')
              .where('category', isEqualTo: category)
              .where("featured", isEqualTo: "true")
              .where(
                "requiredSubjects",
                arrayContainsAny: auth.currentUser?.results?.keys.toList(),
              )
              .where("minimumPoints",
                  isGreaterThanOrEqualTo: auth.currentUser?.results?["points"])
              .snapshots();
        } else {
          stream = FirebaseFirestore.instance
              .collectionGroup('courses')
              .where('category', isEqualTo: category)
              .where("featured", isEqualTo: "true")
              .snapshots();
        }
      }
    } catch (e) {
      print(e);
    }

    // transform stream

    return stream.transform(streamTransformer);
  }
}
