import 'package:course_guide/views/global_widgets/input_text.dart';
import 'package:course_guide/views/home/universities/guc_form/guc_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class GucFormView extends StatelessWidget {
  const GucFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final form = context.watch<GucForm>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUC Form (For Testing purposes)'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Personal Details",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            TextInput2(
              label: 'Surname',
              value: form.surname.value,
              onChanged: form.changeSurname,
              error: form.surname.error,
            ),
            TextInput2(
              label: 'Date of Birth',
              value: form.dob.value,
              onChanged: form.changeDob,
              error: form.dob.error,
            ),
            TextInput2(
              label: 'Town/City/Village',
              value: form.city.value,
              onChanged: form.changeCity,
              error: form.city.error,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Contact Details",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // email input
            TextInput2(
              label: 'Email',
              value: form.email.value,
              onChanged: form.changeEmail,
              error: form.email.error,
            ),
            // postal address input
            TextInput2(
              label: 'Postal Address',
              value: form.postalAddress.value,
              onChanged: form.changePostalAddress,
              error: form.postalAddress.error,
            ),
            // telephone input
            TextInput2(
              label: 'Telephone',
              value: form.telephone.value,
              onChanged: form.changeTelephone,
              error: form.telephone.error,
            ),
            // cellphone input
            TextInput2(
              label: "Cellphone",
              value: form.cellphone.value,
              onChanged: form.changeCellphone,
              error: form.cellphone.error,
            ),
            // district input
            TextInput2(
              label: "District",
              value: form.district.value,
              onChanged: form.changeDistrict,
              error: form.district.error,
            ),
            // gender radio buttons
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                      title: Text("Male"),
                      value: "Male",
                      groupValue: form.gender.value,
                      onChanged: form.changeGender),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text("Female"),
                    value: "Female",
                    groupValue: form.gender.value,
                    onChanged: form.changeGender,
                  ),
                ),
              ],
            ),
            // nationality input
            TextInput2(
              label: "Nationality",
              value: form.nationality.value,
              onChanged: form.changeNationality,
              error: form.nationality.error,
            ),
            // omang input
            TextInput2(
              label: "Omang/Passport",
              value: form.omang.value,
              onChanged: form.changeOmang,
              error: form.omang.error,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Next Of Kin Details",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // next of kin input
            TextInput2(
              label: "Next of Kin",
              value: form.nextOfKin.value,
              onChanged: form.changeNextOfKin,
              error: form.nextOfKin.error,
            ),
            // next of kin telephone input
            TextInput2(
              label: "Next of Kin Contact",
              value: form.nextOfKinContact.value,
              onChanged: form.changeNextOfKinContact,
              error: form.nextOfKinContact.error,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Employer Details",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // employer name
            TextInput2(
              label: "Employer Name",
              value: form.employerName.value,
              onChanged: form.changeEmployerName,
              error: form.employerName.error,
            ),
            // employer address
            TextInput2(
              label: "Employer Address",
              value: form.emplyoyerAddress.value,
              onChanged: form.changeEmployerAddress,
              error: form.emplyoyerAddress.error,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Education Details",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // course enrolled for input
            TextInput2(
              label: "Course Enrolled For",
              value: form.courseEnrolledFor.value,
              onChanged: form.changeCourseEnrolledFor,
              error: form.courseEnrolledFor.error,
            ),
            // total Points input
            TextInput2(
              label: "Total Points",
              value: form.totalPoints.value,
              onChanged: form.changeTotalPoints,
              error: form.totalPoints.error,
            ),
            // year of completion input
            TextInput2(
              label: "Year of Completion",
              value: form.yearOfCompletion.value,
              onChanged: form.changeYearOfCompletion,
              error: form.yearOfCompletion.error,
            ),
            // course duration
            TextInput2(
              label: "Course Duration",
              value: form.courseDuration.value,
              onChanged: form.changeCourseDuration,
              error: form.courseDuration.error,
            ),
            // expandable list of courses

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "BGCSE RESULTS",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                children: [
                  for (int i = 0; i < form.bgcseCourses.length; i++)
                    TableRow(
                      children: [
                        TableCell(
                          child: SizedBox(
                              width: 300,
                              height: 40,
                              child: TextFormField(
                                initialValue: form.bgcseCourses[i].value,
                                decoration: InputDecoration(
                                  hintText: "Subject",
                                  errorText: form.bgcseCourses[i].error,
                                ),
                                onChanged: (e) {
                                  form.changeBgcseCourse(i, e);
                                },
                              )),
                        ),
                        TableCell(
                          child: SizedBox(
                            width: 300,
                            height: 40,
                            child: TextFormField(
                              initialValue: form.bgcseGrades[i].value,
                              decoration: InputDecoration(
                                  errorText: form.bgcseGrades[i].error,
                                  hintText: "Grade",
                                  suffixIcon: IconButton(
                                    icon: Icon(FontAwesomeIcons.trash),
                                    onPressed: () {
                                      final index = form.removeBgcseCourse(i);
                                    },
                                  )),
                              onChanged: (e) {
                                form.changeBgcseGrade(i, e);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            // row of minus and add button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: form.addBgcseCourse,
                child: Text(
                  "Add Subject",
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Tetiary".toUpperCase(),
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                children: [
                  for (int i = 0; i < form.tetiaries.length; i++)
                    TableRow(
                      children: [
                        TableCell(
                          child: SizedBox(
                              width: 300,
                              height: 40,
                              child: TextFormField(
                                initialValue: form.tetiaries[i].value,
                                decoration: InputDecoration(
                                  hintText: "Institution",
                                  errorText: form.tetiaries[i].error,
                                ),
                                onChanged: (e) {
                                  form.changeTetiary(i, e);
                                },
                              )),
                        ),
                        TableCell(
                          child: SizedBox(
                            width: 300,
                            height: 40,
                            child: TextFormField(
                              initialValue: form.tetiaryGrades[i].value,
                              decoration: InputDecoration(
                                hintText: "Qualification",
                                errorText: form.tetiaryGrades[i].error,
                              ),
                              onChanged: (e) {
                                form.changeTetiaryQualification(i, e);
                              },
                            ),
                          ),
                        ),
                        TableCell(
                          child: SizedBox(
                            width: 300,
                            height: 40,
                            child: TextFormField(
                              initialValue: form.tetiaryYears[i].value,
                              decoration: InputDecoration(
                                  hintText: "Year",
                                  errorText: form.tetiaryGrades[i].error,
                                  suffixIcon: IconButton(
                                    icon: Icon(FontAwesomeIcons.trash),
                                    onPressed: () {
                                      form.removeTetiary(i);
                                    },
                                  )),
                              onChanged: (e) {
                                form.changeTetiaryYear(i, e);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            // row of minus and add button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: form.addTetiary,
                child: Text(
                  "Add Tetiary",
                ),
              ),
            ),

            // declaration text with check box
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "1. I shall attend lessons as per arrangement with the school and I shall sit for my examinations on completion of study period or when ready and any extra lessons attended after the elapse of the agreed duration shall be payable to the school.",
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "2. Failure to attend lessons shall lead to delays in sitting for examinations for which the school shall not be held liable.",
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      " 3.ALL EXTERNAL EXAMINATION FEES ARE PAID SEPARETELY AND CANNOT BE STIPULATED AS FIXED AMOUNTS DUE TO FLUCTUATION OF EXCHANGE OF RATES. FIND MORE DETAILS UPON ENROLMENT.",
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "4. I shall pay my course fees in advance on orb before the 30th of every month; Failure to do so will result in a penalty / late fee of P10.00 per day.",
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "5. No amount of fees already paid shall be refundable, unless GABORONE UNIVERSAL COLLEGE OF LAW decides to cancel the course.",
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "6. A student who enrolls for a course shall be obliged to complete his or her studies in the course. Withdrawal from the course shall not render unplayable the outstanding balance for the course student enrolled for. A person who enrolls for a course shall be bond to pay the entire course fees regardless of whether they as an after thought or otherwise decide to withdraw from the course.",
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      " 7. I undertake to remain a student of GUC for the entire duration of the course / Programme. And I agree to pay one semesters fee as a penalty for breach of this undertaking",
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: form.declaration,
                          onChanged: (e) {
                            form.changeDeclaration(e);
                          },
                        ),
                        Expanded(
                          child: Text(
                            "I HAVE READ AND UNDERSTOOD THE ABOVE TERMS, AND I HEREBY AGREE TO ABIDE BY THEM.",
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // submit button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: form.declaration == true
                    ? () async {
                        form.validate();
                        if (form.isValid()) {
                          await form.submit();
                          // show dialog
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Success"),
                                  content: Text("Form submitted successfully"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Ok"))
                                  ],
                                );
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text("Please fill all the fields"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Ok"))
                                  ],
                                );
                              });
                        }
                      }
                    : null,
                child: Text(
                  "Submit",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
