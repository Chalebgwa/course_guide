import 'dart:ui';

import 'package:course_guide/views/global_widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Column(
          children: [
            // x button in the center
            Center(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.circleXmark,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),

            const TextInput(label: "Full Name"),
            const TextInput(label: "Username"),
            const TextInput(label: "Email"),
            const TextInput(label: "Password"),
            const TextInput(label: "Confirm Password"),
          ],
        ),
      ),
    );
  }
}
