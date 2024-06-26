import 'package:course_guide/controllers/auth.dart';
import 'package:course_guide/controllers/courses_controller.dart';
import 'package:course_guide/views/authentication/sign_up.dart';
import 'package:course_guide/views/home/profile/widget/edit_profile.dart';
import 'package:course_guide/views/home/profile/widget/my_course_list.dart';
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
    final courseController = context.watch<CourseController>();
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
            text: "My Courses",
            icon: FontAwesomeIcons.file,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyCourseList(),
                ),
              );
            }),
        const SizedBox(height: 20),
        ProfileButton(
            text: "Filter My Courses",
            icon: FontAwesomeIcons.filter,
            leading: Switch(
              value: courseController.showFilter,
              onChanged: (value) {
                courseController.toggleFilter();
              },
            ),
            onTap: () {
              courseController.toggleFilter();

            }),
        const SizedBox(height: 20),
        ProfileButton(
            text: "My Subjects",
            icon: FontAwesomeIcons.book,
            onTap: () async {

              Map<String,dynamic>? data = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsForm(),
                ),
              );

              if(data?.isNotEmpty == true){
                courseController.updateResults(data!).then((value) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Results Updated"),
                    )
                ),);
              }

            }),


      ],
    );
  }
}
