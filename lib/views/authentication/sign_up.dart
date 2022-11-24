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
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      await auth.signUpWithEmailAndPassword(
                                          _emailController.text,
                                          _confirmPasswordController.text,
                                          _fullnameController.text,
                                          _locationController.text,
                                          _selectedDate!);
                                      if (mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Sign up successful, please login'),
                                          ),
                                        );
                                        context.go("/home");
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
