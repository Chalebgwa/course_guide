import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/controllers/auth.dart';
import 'package:course_guide/util/validation_item.dart';
import 'package:flutter/cupertino.dart';
// import intl
import 'package:intl/intl.dart';

class GucForm extends ChangeNotifier {
  final Auth auth;

  GucForm({required this.auth}) {
    surname = ValidationItem(value: auth.currentUser?.name.split(" ").last);
    otherNames = ValidationItem(value: auth.currentUser?.name.split(" ").first);
    email = ValidationItem(value: auth.currentUser?.email);
    cellphone = ValidationItem(value: auth.currentUser?.phone);
    dob =
        ValidationItem(value: DateFormat.yMd().format(auth.currentUser!.dob!));
    city = ValidationItem(value: auth.currentUser?.location);
  }

  // url
  String? url;

  void changeUrl(String? value) {
    url = value;
    notifyListeners();
  }

  ValidationItem surname = ValidationItem();
  ValidationItem otherNames = ValidationItem();
  ValidationItem dob = ValidationItem();
  ValidationItem city = ValidationItem();
  ValidationItem email = ValidationItem();
  ValidationItem postalAddress = ValidationItem();
  ValidationItem telephone = ValidationItem();
  ValidationItem cellphone = ValidationItem();
  ValidationItem district = ValidationItem();
  ValidationItem gender = ValidationItem();
  ValidationItem omang = ValidationItem();
  ValidationItem nextOfKin = ValidationItem();
  ValidationItem nextOfKinContact = ValidationItem();

  // employer details
  ValidationItem employerName = ValidationItem();
  ValidationItem emplyoyerAddress = ValidationItem();

  // course details
  ValidationItem courseEnrolledFor = ValidationItem();
  ValidationItem courseDuration = ValidationItem();

  // BGCSE results
  ValidationItem yearOfCompletion = ValidationItem();
  List<ValidationItem> bgcseCourses = [];
  List<ValidationItem> bgcseGrades = [];
  ValidationItem totalPoints = ValidationItem();

  //Tetiary results
  List<ValidationItem> tetiaries = [];
  List<ValidationItem> tetiaryGrades = [];
  List<ValidationItem> tetiaryYears = [];
  bool? declaration = false;
  ValidationItem nationality = ValidationItem();

  String? currentCourse;

  void changeNationality(String? value) {
    if (value == null || value.isEmpty) {
      nationality =
          ValidationItem(value: value, error: "Nationality is required");
    } else {
      nationality = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeCurrentCourse(String? value) {
    currentCourse = value;
    notifyListeners();
  }

  void changeSurname(String? value) {
    if (value == null || value.isEmpty) {
      surname = ValidationItem(value: value, error: 'Surname is required');
    } else {
      surname = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeOtherNames(String? value) {
    if (value == null || value.isEmpty) {
      otherNames =
          ValidationItem(value: value, error: 'Other names are required');
    } else {
      otherNames = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeDob(String? value) {
    if (value == null || value.isEmpty) {
      dob = ValidationItem(value: value, error: 'Date of birth is required');
    } else {
      dob = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeCity(String? value) {
    if (value == null || value.isEmpty) {
      city = ValidationItem(value: value, error: 'City is required');
    } else {
      city = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeEmail(String? value) {
    if (value == null || value.isEmpty) {
      email = ValidationItem(value: value, error: 'Email is required');
    } else {
      email = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changePostalAddress(String? value) {
    if (value == null || value.isEmpty) {
      postalAddress =
          ValidationItem(value: value, error: 'Postal address is required');
    } else {
      postalAddress = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeTelephone(String? value) {
    if (value == null || value.isEmpty) {
      telephone = ValidationItem(value: value, error: 'Telephone is required');
    } else {
      telephone = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeCellphone(String? value) {
    if (value == null || value.isEmpty) {
      cellphone = ValidationItem(value: value, error: 'Cellphone is required');
    } else {
      cellphone = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeDistrict(String? value) {
    if (value == null || value.isEmpty) {
      district = ValidationItem(value: value, error: 'District is required');
    } else {
      district = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeGender(String? value) {
    if (value == null || value.isEmpty) {
      gender = ValidationItem(value: value, error: "Gender is Required");
    } else {
      gender = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeOmang(String? value) {
    if (value == null || value.isEmpty) {
      omang = ValidationItem(value: value, error: 'Omang is required');
    } else {
      omang = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeNextOfKin(String? value) {
    if (value == null || value.isEmpty) {
      nextOfKin =
          ValidationItem(value: value, error: 'Next of kin is required');
    } else {
      nextOfKin = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeNextOfKinContact(String? value) {
    if (value == null || value.isEmpty) {
      nextOfKinContact = ValidationItem(
          value: value, error: 'Next of kin contact is required');
    } else {
      nextOfKinContact = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeEmployerName(String? value) {
    if (value == null || value.isEmpty) {
      employerName =
          ValidationItem(value: value, error: 'Employer name is required');
    } else {
      employerName = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeEmployerAddress(String? value) {
    if (value == null || value.isEmpty) {
      emplyoyerAddress =
          ValidationItem(value: value, error: 'Employer address is required');
    } else {
      emplyoyerAddress = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeCourseEnrolledFor(String? value) {
    if (value == null || value.isEmpty) {
      courseEnrolledFor = ValidationItem(
          value: value, error: 'Course enrolled for is required');
    } else {
      courseEnrolledFor = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeCourseDuration(String? value) {
    if (value == null || value.isEmpty) {
      courseDuration =
          ValidationItem(value: value, error: 'Course duration is required');
    } else {
      courseDuration = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeYearOfCompletion(String? value) {
    if (value == null || value.isEmpty) {
      yearOfCompletion =
          ValidationItem(value: value, error: 'Year of completion is required');
    } else {
      yearOfCompletion = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeTotalPoints(String? value) {
    if (value == null || value.isEmpty) {
      totalPoints =
          ValidationItem(value: value, error: 'Total points is required');
    } else {
      totalPoints = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void changeDeclaration(bool? value) {
    declaration = value;
    notifyListeners();
  }

  void addBgcseCourse() {
    bgcseCourses.add(ValidationItem());
    addBgcseGrade();
    notifyListeners();
  }

  void removeBgcseCourse(int index) {
    bgcseCourses.removeAt(index);
    removeBgcseGrade(index);
    notifyListeners();
  }

  void changeBgcseCourse(int index, String? value) {
    if (value == null || value.isEmpty) {
      bgcseCourses[index] =
          ValidationItem(value: value, error: 'Course is required');
    } else {
      bgcseCourses[index] = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void addBgcseGrade() {
    bgcseGrades.add(ValidationItem());
    notifyListeners();
  }

  void removeBgcseGrade(int index) {
    bgcseGrades.removeAt(index);
    notifyListeners();
  }

  void changeBgcseGrade(int index, String? value) {
    if (value == null || value.isEmpty) {
      bgcseGrades[index] =
          ValidationItem(value: value, error: 'Grade is required');
    } else {
      bgcseGrades[index] = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void addTetiary() {
    tetiaries.add(ValidationItem());
    addTetiaryYear();

    addTetiaryGrades();
    notifyListeners();
  }

  void removeTetiary(int index) {
    tetiaries.removeAt(index);
    removeTetiaryYear(index);
    removeTetiaryQualifications(index);

    notifyListeners();
  }

  void changeTetiary(int index, String? value) {
    if (value == null || value.isEmpty) {
      tetiaries[index] =
          ValidationItem(value: value, error: 'Tetiary is required');
    } else {
      tetiaries[index] = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void addTetiaryGrades() {
    tetiaryGrades.add(ValidationItem());
    notifyListeners();
  }

  void removeTetiaryQualifications(int index) {
    tetiaryGrades.removeAt(index);
    notifyListeners();
  }

  void changeTetiaryQualification(int index, String? value) {
    if (value == null || value.isEmpty) {
      tetiaryGrades[index] =
          ValidationItem(value: value, error: 'Grade is required');
    } else {
      tetiaryGrades[index] = ValidationItem(value: value);
    }
    notifyListeners();
  }

  void addTetiaryYear() {
    tetiaryYears.add(ValidationItem());
    notifyListeners();
  }

  void removeTetiaryYear(int index) {
    tetiaryYears.removeAt(index);
    notifyListeners();
  }

  void changeTetiaryYear(int index, String? value) {
    if (value == null || value.isEmpty) {
      tetiaryYears[index] =
          ValidationItem(value: value, error: 'Year is required');
    } else {
      tetiaryYears[index] = ValidationItem(value: value);
    }
    notifyListeners();
  }

  bool isValid() {
    return surname.isValid() &&
        email.isValid() &&
        city.isValid() &&
        omang.isValid() &&
        nextOfKin.isValid() &&
        nextOfKinContact.isValid() &&
        employerName.isValid() &&
        emplyoyerAddress.isValid() &&
        courseEnrolledFor.isValid() &&
        yearOfCompletion.isValid() &&
        totalPoints.isValid() &&
        declaration == true &&
        courseDuration.isValid() &&
        bgcseCourses.every((element) => element.isValid()) &&
        bgcseGrades.every((element) => element.isValid()) &&
        tetiaries.every((element) => element.isValid()) &&
        tetiaryGrades.every((element) => element.isValid()) &&
        tetiaryYears.every((element) => element.isValid());
  }

  Future<void> submit() async {
    if (isValid()) {
      FirebaseFirestore.instance
          .collection("applications")
          .doc(auth.currentUser!.uid)
          .set({
            "date": DateTime.now(),
            "surname": surname.value,
            "email": email.value,
            "city": city.value,
            "omang": omang.value,
            "nextOfKin": nextOfKin.value,
            "nextOfKinContact": nextOfKinContact.value,
            "employerName": employerName.value,
            "emplyoyerAddress": emplyoyerAddress.value,
            "courseEnrolledFor": courseEnrolledFor.value,
            "nationality": nationality.value,
            "courseDuration": courseDuration.value,
            "yearOfCompletion": yearOfCompletion.value,
            "totalPoints": totalPoints.value,
            "declaration": declaration,
            "bgcseCourses": bgcseCourses.map((e) => e.value).toList(),
            "bgcseGrades": bgcseGrades.map((e) => e.value).toList(),
            "tetiaries": tetiaries.map((e) => e.value).toList(),
            "tetiaryQualifications": tetiaryGrades.map((e) => e.value).toList(),
            "tetiaryYears": tetiaryYears.map((e) => e.value).toList(),
          })
          .then((value) => print("Application Submitted"))
          .catchError((error) => print("Failed to submit application: $error"));
    }
  }

  void validate() {
    // call every validation method with the current value
    changeSurname(surname.value);
    changeEmail(email.value);
    changeCity(city.value);
    changeOmang(omang.value);
    changeNextOfKin(nextOfKin.value);
    changeNextOfKinContact(nextOfKinContact.value);
    changeEmployerName(employerName.value);
    changeEmployerAddress(emplyoyerAddress.value);
    changeCourseEnrolledFor(courseEnrolledFor.value);
    changeCourseDuration(courseDuration.value);
    changeYearOfCompletion(yearOfCompletion.value);
    changeTotalPoints(totalPoints.value);
    changeDistrict(district.value);
    changeDob(dob.value);
    changePostalAddress(postalAddress.value);
    changeTelephone(telephone.value);
    changeCellphone(cellphone.value);
    changeGender(gender.value);
    changeNationality(nationality.value);
    for (ValidationItem item in bgcseCourses) {
      changeBgcseCourse(bgcseCourses.indexOf(item), item.value);
    }
    for (ValidationItem item in bgcseGrades) {
      changeBgcseGrade(bgcseGrades.indexOf(item), item.value);
    }
    for (ValidationItem item in tetiaries) {
      changeTetiary(tetiaries.indexOf(item), item.value);
    }
    for (ValidationItem item in tetiaryGrades) {
      changeTetiaryQualification(tetiaryGrades.indexOf(item), item.value);
    }
    for (ValidationItem item in tetiaryYears) {
      changeTetiaryYear(tetiaryYears.indexOf(item), item.value);
    }
  }
}
