// import json
import 'dart:convert';
import 'dart:io';

// import firebase firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/models/db_init.dart';
import 'package:course_guide/models/user.dart';
// import firebase auth
import 'package:firebase_auth/firebase_auth.dart';
// import storage
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// image picker
import 'package:image_picker/image_picker.dart';
// import local storage
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  // scaffold key
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> signUpKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> signInKey = GlobalKey<ScaffoldState>();

  Auth() {
    // get user data from local storage
    SharedPreferences.getInstance().then((prefs) {
      // get user data
      final String? userData = prefs.getString('user');
      // if user data is not null
      if (userData != null) {
        // set current user
        _currentUser = Client.fromMap(jsonDecode(userData));
        // set is authenticated to true
        _isAuthenticated = true;
        // notify listeners
        //scaffoldKey.currentState!.context.go('/home');
        notifyListeners();
      }
    });
  }

  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');
    if (userData != null) {
      _currentUser = Client.fromMap(jsonDecode(userData));
      _isAuthenticated = true;
      notifyListeners();
    }
  }

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

      if (userCredential.user != null &&
          userCredential.user?.emailVerified == false) {
        if (signInKey.currentContext != null) {
          ScaffoldMessenger.of(signInKey.currentContext!).showSnackBar(SnackBar(
            content: Text("Check Your email to verify your account"),
            duration: Duration(seconds: 5),
          ));
        }

        return;
      }
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
      // Persist user data to local storage
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user', jsonEncode(data));

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
  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String location,
    DateTime dob, {
    Map<String, dynamic>? result,
  }) async {
    try {
      // sign up with email and password
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // get user id
      final String uid = userCredential.user!.uid;

      // send confirmed email
      userCredential.user?.sendEmailVerification().then((value) {
        if (signUpKey.currentContext != null) {
          ScaffoldMessenger.of(signUpKey.currentContext!).showSnackBar(SnackBar(
            content: Text("Check Your email to verify your account"),
            duration: Duration(seconds: 5),
          ));
        }
      });
      // create user data
      final Map<String, dynamic> data = <String, dynamic>{
        'uid': uid,
        'email': email,
        'name': name,
        'photoURL': null,
        'location': location,
        'createdAt': DateTime.now().toIso8601String(),
        'dob': dob.toIso8601String(),
        'result': result
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
    // REMOVE USER DATA FROM LOCAL STORAGE
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('user');
    });

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
        final ref = FirebaseStorage.instance.ref('users/$uid/profile.jpg');
        await ref.putFile(File(path));
        // get download url
        final String downloadURL = await ref.getDownloadURL();

        _currentUser!.copyWith(photoURL: downloadURL);
        // notify listeners
        // update user data in firestore
        FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update(<String, dynamic>{
          'photoURL': downloadURL,
        });
        notifyListeners();
      }
    } on FirebaseException catch (e) {
      // if error is unknown
      print(e.message);
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

  void logout() {
    _isAuthenticated = false;
    _currentUser = null;
    // REMOVE USER DATA FROM LOCAL STORAGE
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('user');
    });
    notifyListeners();
  }

  // create
}
