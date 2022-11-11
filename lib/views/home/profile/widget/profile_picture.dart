import 'package:badges/badges.dart';
import 'package:course_guide/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({Key? key, required this.client}) : super(key: key);
  final Client client;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 118.h,
      width: 118.w,
      child: CircleAvatar(
        backgroundColor: HexColor("#40A49C"),
        child: Badge(
          position: BadgePosition.bottomEnd(bottom: 0, end: 0),
          badgeColor: HexColor('#FFD700'),
          badgeContent: Icon(
            Icons.edit,
            color: HexColor("#40A49C"),
            size: 15,
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: client.photoURL != null
                ? Image.network(client.photoURL!).image
                : AssetImage("assets/blank-profile-picture-973460_1280.webp"),
                
          ),
        ),
      ),
    );
  }
}
