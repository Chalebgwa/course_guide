import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/controllers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // create a form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // create a text editing controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  DateTime? _selectedDate;
  // date c
  // create a text editing controller
  final TextEditingController dateController = TextEditingController();
  // location controller
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);
    return Scaffold(
      key: auth.signUpKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          //color: Colors.black.withOpacity(0.5),
          image: DecorationImage(
            image: AssetImage('assets/04.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 1.7,
            child: Column(
              children: [
                // back button
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // sign up form wrapped with card and to curved corners
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 300),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: SizedBox(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Full Name",
                                    style: TextStyle(
                                      color: HexColor("#40A49C"),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextFormField(
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your full name';
                                      }
                                      return null;
                                    },
                                    controller: _fullnameController,
                                    decoration: InputDecoration(
                                      fillColor: HexColor("#F2F3F7"),
                                      filled: true,
                                      hintText: "Full Name",
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                      color: HexColor("#40A49C"),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _emailController,
                                    validator: (value) => value?.isEmpty ?? true
                                        ? "Email cannot be empty"
                                        : null,
                                    decoration: InputDecoration(
                                      fillColor: HexColor("#F2F3F7"),
                                      filled: true,
                                      hintText: "Email",
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // date of birth picker
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date of Birth",
                                    style: TextStyle(
                                      color: HexColor("#40A49C"),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextFormField(
                                    readOnly: true,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your date of birth';
                                      }
                                      return null;
                                    },
                                    controller: dateController,
                                    onTap: () async {
                                      final DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                      );
                                      if (pickedDate != null) {
                                        setState(() {
                                          _selectedDate = pickedDate;
                                          dateController.text = _selectedDate ==
                                                  null
                                              ? ''
                                              : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      fillColor: HexColor("#F2F3F7"),
                                      filled: true,
                                      hintText: "Date of Birth",
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // location text field
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Location",
                                    style: TextStyle(
                                      color: HexColor("#40A49C"),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _locationController,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your location';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      fillColor: HexColor("#F2F3F7"),
                                      filled: true,
                                      hintText: "Location",
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // password field
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Password",
                                    style: TextStyle(
                                      color: HexColor("#40A49C"),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _passwordController,
                                    validator: (String? value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length < 6) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      fillColor: HexColor("#F2F3F7"),
                                      filled: true,
                                      hintText: "Password",
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // confirm password field
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Confirm Password",
                                    style: TextStyle(
                                      color: HexColor("#40A49C"),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    validator: (String? value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value != _passwordController.text) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      fillColor: HexColor("#F2F3F7"),
                                      filled: true,
                                      hintText: "Confirm Password",
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // sign up button
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: ElevatedButton(
                                onPressed: () async {
                                  Map<String, String>? data = await showDialog(
                                    context: context,
                                    builder: (context) => const ResultsForm(),
                                  );

                                  if (data != null) {
                                    print(data);
                                  } else {
                                    print("no data");
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      await auth.signUpWithEmailAndPassword(
                                        _emailController.text,
                                        _confirmPasswordController.text,
                                        _fullnameController.text,
                                        _locationController.text,
                                        _selectedDate!,
                                        result: data,
                                      );
                                      if (mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Sign up successful, please verify your email and login'),
                                          ),
                                        );
                                        context.go("/sign-in");
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(e.toString()),
                                      ));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Please fill in all fields"),
                                    ));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: HexColor("#40A49C"),
                                  fixedSize: const Size(300, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            // already have an account text
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                      color: HexColor("#40A49C"),
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.go("/sign-in");
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: HexColor("#40A49C"),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResultsForm extends StatefulWidget {
  const ResultsForm({Key? key}) : super(key: key);

  @override
  _ResultsFormState createState() => _ResultsFormState();
}

class _ResultsFormState extends State<ResultsForm> {
  final _formKey = GlobalKey<FormState>();
  // collect best 6 subjects and their grades
  final _subject1Controller = TextEditingController();
  final _subject2Controller = TextEditingController();
  final _subject3Controller = TextEditingController();
  final _subject4Controller = TextEditingController();
  final _subject5Controller = TextEditingController();
  final _subject6Controller = TextEditingController();

  final _grade1Controller = TextEditingController();
  final _grade2Controller = TextEditingController();
  final _grade3Controller = TextEditingController();
  final _grade4Controller = TextEditingController();
  final _grade5Controller = TextEditingController();
  final _grade6Controller = TextEditingController();
  final _pointsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results Form'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection("subs").snapshots(),
          builder: (context, snapshot) {
            final allSubjects = snapshot.data?.docs
                .map<String>((e) => e.data()["name"])
                .toList();
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Points",
                            style: TextStyle(
                              color: HexColor("#40A49C"),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextFormField(
                            controller: _pointsController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your points';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: HexColor("#F2F3F7"),
                              filled: true,
                              hintText: "Points",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Enter your best 6 subjects and grades, along with your grades",
                          style: TextStyle(
                            color: HexColor("#40A49C"),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    // row of subject and grade
                    buildSubject(
                        _subject1Controller, _grade1Controller, allSubjects),
                    buildSubject(
                        _subject2Controller, _grade2Controller, allSubjects),
                    buildSubject(
                        _subject3Controller, _grade3Controller, allSubjects),
                    buildSubject(
                        _subject4Controller, _grade4Controller, allSubjects),
                    buildSubject(
                        _subject5Controller, _grade5Controller, allSubjects),
                    buildSubject(
                        _subject6Controller, _grade6Controller, allSubjects),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // create a map of subjects and grades
                          Map<String, String> results = {
                            _subject1Controller.text: _grade1Controller.text,
                            _subject2Controller.text: _grade2Controller.text,
                            _subject3Controller.text: _grade3Controller.text,
                            _subject4Controller.text: _grade4Controller.text,
                            _subject5Controller.text: _grade5Controller.text,
                            _subject6Controller.text: _grade6Controller.text,
                            "points": _pointsController.text,
                          };

                          // save the results to the database
                          Navigator.pop(context, results);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please fill in all fields"),
                            ),
                          );
                        }
                      },
                      child: Text("Save"),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(300.w, 40.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Skip"),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(300.w, 40.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Row buildSubject(TextEditingController subject, TextEditingController grade,
      List<String>? allSubjects) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
              validator: (value) {
                if (value == null) {
                  return 'Please select a subject';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Subject",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: allSubjects
                      ?.map(
                        (e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                      )
                      .toList() ??
                  [],
              onChanged: (value) {
                subject.text = value.toString();
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: grade,
              validator: (value) {
                if (value?.isEmpty == true) {
                  return 'Please enter a grade';
                }
                // check if grade is valid
                if (value != null && value.isNotEmpty) {
                  if (int.tryParse(value) != null) {
                    return 'Please enter a valid grade';
                  }
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Grade",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
