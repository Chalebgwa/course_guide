import 'dart:io';

import 'package:course_guide/models/db_init.dart';
import 'package:course_guide/models/user.dart';
import 'package:flutter/material.dart';
// import firebase auth
import 'package:firebase_auth/firebase_auth.dart';
// import firebase firestore
import 'package:cloud_firestore/cloud_firestore.dart';
// image picker
import 'package:image_picker/image_picker.dart';

// import storage
import 'package:firebase_storage/firebase_storage.dart';

class Auth extends ChangeNotifier {
  // scaffold key
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isAuthenticated = false;

  Client? _currentUser;
  bool isloading = false;

  bool get isAuthenticated => _isAuthenticated;

  Client? get currentUser => _currentUser;

  void initDB() {
    final uniRef = FirebaseFirestore.instance.collection("universities");

    for (Map<String, dynamic> doc in data) {
      uniRef.doc(doc["key"]).collection("courses").doc(doc['title']).set(doc);
    }
  }

  // sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    initDB();
    try {
      // sign in with email and password
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // get user id
      final String uid = userCredential.user!.uid;
      // get user data from firestore
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      // get user data
      final Map<String, dynamic> data = documentSnapshot.data()!;
      // set current user
      _currentUser = Client.fromMap(data);
      // set is authenticated to true
      _isAuthenticated = true;
      // notify listeners
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // if error is invalid email
      if (e.code == 'invalid-email') {
        throw 'Invalid email';
      }
      // if error is wrong password
      if (e.code == 'wrong-password') {
        throw 'Wrong password';
      }
      // if error is user not found
      if (e.code == 'user-not-found') {
        throw 'User not found';
      }
      // if error is user disabled
      if (e.code == 'user-disabled') {
        throw 'User disabled';
      }
      // if error is too many requests
      if (e.code == 'too-many-requests') {
        throw 'Too many requests';
      }
      // if error is operation not allowed
      if (e.code == 'operation-not-allowed') {
        throw 'Operation not allowed';
      }
      // if error is unknown
      throw 'Unknown error';
    }
  }

  // sign up with email and password, name and location
  Future<void> signUpWithEmailAndPassword(String email, String password,
      String name, String location, DateTime dob) async {
    try {
      // sign up with email and password
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // get user id
      final String uid = userCredential.user!.uid;
      // create user data
      final Map<String, dynamic> data = <String, dynamic>{
        'uid': uid,
        'email': email,
        'name': name,
        'photoURL': null,
        'location': location,
        'createdAt': DateTime.now().toIso8601String(),
        'dob': dob.toIso8601String(),
      };
      // set current user
      _currentUser = Client.fromMap(data);
      // set is authenticated to true
      _isAuthenticated = true;
      // notify listeners
      notifyListeners();
      // add user data to firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set(data);
    } on FirebaseAuthException catch (e) {
      // if error is invalid email
      if (e.code == 'invalid-email') {
        throw 'Invalid email';
      }
      // if error is email already in use
      if (e.code == 'email-already-in-use') {
        throw 'Email already in use';
      }
      // if error is weak password
      if (e.code == 'weak-password') {
        throw 'Weak password';
      }
      // if error is operation not allowed
      if (e.code == 'operation-not-allowed') {
        throw 'Operation not allowed';
      }
      // if error is unknown
      throw 'Unknown error';
    }
  }

  // send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      // send password reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      // if error is invalid email
      if (e.code == 'invalid-email') {
        throw 'Invalid email';
      }
      // if error is user not found
      if (e.code == 'user-not-found') {
        throw 'User not found';
      }
      // if error is unknown
      throw 'Unknown error';
    }
  }

  void authenticate() {
    _isAuthenticated = true;
    notifyListeners();
  }

  void unAuthenticate() {
    _isAuthenticated = false;
    notifyListeners();
  }

  // change profile photo from file picker
  Future<void> changeProfilePhoto() async {
    try {
      isloading = true;
      notifyListeners();
      // get file from file picker
      final XFile? file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      // if file is not null
      if (file != null) {
        // get file path
        final String path = file.path;
        // get user id
        final String uid = _currentUser!.uid;
        // upload file to firebase storage
        final TaskSnapshot taskSnapshot = await FirebaseStorage.instance
            .ref('users/$uid/profile.jpg')
            .putFile(
              File(path),
            );
        // get download url
        final String downloadURL = await taskSnapshot.ref.getDownloadURL();
        // update user data in firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update(<String, dynamic>{'photoURL': downloadURL});
        // update current user
        _currentUser!.copyWith(photoURL: downloadURL);
        // notify listeners
        notifyListeners();
      }
    } on FirebaseException catch (e) {
      // if error is unknown
      //throw e.message;
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<void> updateUser(
      {String? fullname,
      String? email,
      String? phone,
      String? password,
      String? username}) async {
    try {
      // get user id
      final String uid = _currentUser!.uid;
      // update user data in firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update(<String, dynamic>{
        'name': fullname,
        'email': email,
        'phone': phone,
        'username': username,
      });
      // update current user
      _currentUser = _currentUser!.copyWith(
        name: fullname,
        email: email,
      );
      // notify listeners
      notifyListeners();
    } on FirebaseException catch (e) {
      // if error is unknown
      //throw e.message;
    }
  }

  // create
}
