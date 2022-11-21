import 'package:course_guide/controllers/auth.dart';
import 'package:course_guide/util/validation_item.dart';
import 'package:flutter/material.dart';

class ProfileForm extends ChangeNotifier {
  final Auth auth;

  ValidationItem fullname = ValidationItem();
  ValidationItem email = ValidationItem();
  ValidationItem phone = ValidationItem();
  ValidationItem password = ValidationItem();
  ValidationItem confirmPassword = ValidationItem();

  ProfileForm(this.auth);

  void changeFullname(String value) {
    if (value.isNotEmpty) {
      fullname = ValidationItem(value: value, error: null);
    } else {
      fullname = ValidationItem(value: value, error: 'Fullname is required');
    }
  }

  void changeEmail(String value) {
    if (value.isNotEmpty) {
      email = ValidationItem(value: value, error: null);
    } else {
      email = ValidationItem(value: value, error: 'Email is required');
    }
  }

  void changePhone(String value) {
    if (value.isNotEmpty) {
      phone = ValidationItem(value: value, error: null);
    } else {
      phone = ValidationItem(value: value, error: 'Phone is required');
    }
  }

  void changePassword(String value) {
    if (value.isNotEmpty) {
      password = ValidationItem(value: value, error: null);
    } else {
      password = ValidationItem(value: value, error: 'Password is required');
    }
  }

  void changeConfirmPassword(String value) {
    if (value.isNotEmpty) {
      confirmPassword = ValidationItem(value: value, error: null);
    } else {
      confirmPassword =
          ValidationItem(value: value, error: 'Confirm password is required');
    }
  }

  bool get isValid {
    return fullname.isValid() &&
        email.isValid() &&
        phone.isValid() &&
        password.isValid() &&
        confirmPassword.isValid();
  }
}
