import 'package:course_guide/controllers/auth.dart';
import 'package:course_guide/views/home/profile/widget/edit_profile.dart';
import 'package:course_guide/views/home/profile/widget/profile_button.dart';
import 'package:course_guide/views/home/profile/widget/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<Auth>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfilePicture(client: auth.currentUser!),
        const SizedBox(height: 20),
        ProfileButton(
            text: "Edit Profile",
            icon: FontAwesomeIcons.user,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const Dialog(
                  insetPadding: EdgeInsets.symmetric(horizontal: 20),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: EditProfileView(),
                ),
              );
            }),
        const SizedBox(height: 20),
        ProfileButton(
            text: "My Courses", icon: FontAwesomeIcons.file, onTap: () {}),
      ],
    );
  }
}
