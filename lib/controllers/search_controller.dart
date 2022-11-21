import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/models/course.dart';
import 'package:course_guide/models/user.dart';
import 'package:flutter/material.dart';

class SearchController extends ChangeNotifier {
  bool _isSearching = false;

  bool get isSearching => _isSearching;

  void startSearch() {
    _isSearching = true;
    notifyListeners();
  }

  void stopSearch() {
    _isSearching = false;
    notifyListeners();
  }

  // search for a user, course or instructor  
  Future<List<dynamic>> search(String query) async {
    // get users
    final List<Client> users = await _searchUsers(query);
    // get courses
    final List<Course> courses = await _searchCourses(query);
    // get instructors
    //final List<Instructor> instructors = await _searchInstructors(query);
    // return list of users, courses and instructors
    return [...users, ...courses,];
  }

  // search for users
  Future<List<Client>> _searchUsers(String query) async {
    // get users from firestore
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    // get users
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        querySnapshot.docs;
    // get users
    final List<Client> users = documents
        .map((QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) =>
            Client.fromMap(documentSnapshot.data()))
        .toList();
    // filter users
    final List<Client> filteredUsers = users
        .where((Client user) =>
            user.name.toLowerCase().contains(query.toLowerCase()) ||
            user.email.toLowerCase().contains(query.toLowerCase()))
        .toList();
    // return filtered users
    return filteredUsers;
  }

  // search for courses
  Future<List<Course>> _searchCourses(String query) async {
    // get courses from firestore
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('courses').get();
    // get courses
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        querySnapshot.docs;
    // get courses
    final List<Course> courses = documents
        .map((QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) =>
            Course.fromJson(documentSnapshot.data()))
        .toList();
    // filter courses
    final List<Course> filteredCourses = courses
        .where((Course course) =>
            course.title.toLowerCase().contains(query.toLowerCase()) ||
            course.description.contains(query.toLowerCase()))
        .toList();

    return filteredCourses;
  }
  
}