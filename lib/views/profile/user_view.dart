import 'package:course_guide/models/user.dart';
import 'package:course_guide/views/home/profile/widget/profile_picture.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key, required this.user}) : super(key: key);

  final Client user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ProfilePicture(client: user),
          Text(
            user.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            user.email,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          // call list tile
         

        ],
      ),
    );
  }
}
