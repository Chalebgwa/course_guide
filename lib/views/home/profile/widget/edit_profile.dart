import 'dart:ui';

import 'package:course_guide/views/global_widgets/input_text.dart';
import 'package:course_guide/views/home/profile/widget/edit_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    final form = context.watch<ProfileForm>();
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                FontAwesomeIcons.circleXmark,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Container(
            height: 340,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // x button in the center
                  SizedBox(
                    height: 10,
                  ),

                   TextInput(
                    label: "Full Name",
                    error: form.fullname.error,
                    onChanged: form.changeFullname,
                    value: form.fullname.value,
                  ), TextInput(
                    label: "Username",
                    error: form.username.error,
                    onChanged: form.changeUsername,
                    value: form.username.value,
                  ),
                 
                  TextInput(
                    label: "Email",
                    error: form.email.error,  
                    onChanged: form.changeEmail,
                    value: form.email.value,
                  ),
                  TextInput(
                    label: "Phone Number",
                    error: form.phone.error,
                    onChanged: form.changePhone,
                    value: form.phone.value,
                  ),
                  // save elevated button
                  ElevatedButton(
                    onPressed: form.submit,
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
