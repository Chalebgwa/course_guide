import 'package:badges/badges.dart';
import 'package:course_guide/controllers/nav_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navController = context.watch<NavController>();
    return Container(
      height: 67.h,
      width: 375.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        color: HexColor("#40A49C"),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BottomNavButton(
            icon: FontAwesomeIcons.home,
            text: "Home",
            isActive: navController.currentRoute == "Home",
          ),
          BottomNavButton(
              icon: FontAwesomeIcons.book,
              text: "Universities",
              isActive: navController.currentRoute == "Universities"),
          BottomNavButton(
              icon: FontAwesomeIcons.question,
              text: "Personality Test",
              isActive: navController.currentRoute == "Personality Test"),
          BottomNavButton(
              icon: FontAwesomeIcons.user,
              text: "Profile",
              isActive: navController.currentRoute == "Profile"),
        ],
      ),
    );
  }
}

// BottomNav button
// Path: lib/views/global_widgets/bottom_nav.dart
// Compare this snippet from lib/router.dart:';

class BottomNavButton extends StatelessWidget {
  const BottomNavButton(
      {Key? key,
      required this.icon,
      required this.text,
      required this.isActive})
      : super(key: key);
  final IconData icon;
  final String text;
  final bool isActive;

  String path() {
    switch (text) {
      case "Home":
        return "/home";
      case "Universities":
        return "/universities";
      case "Personality Test":
        return "/personalitytest";
      case "Profile":
        return "/profile";
      default:
        return "/home";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<NavController>().changeRoute(text);
        context.go(path());
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Badge(
            showBadge: isActive,
            badgeColor: Colors.yellow.withOpacity(.4),
            badgeContent: Container(
              width: 10.w,
              height: 10.h,
              decoration: BoxDecoration(
                // color: Color(0xFFFDE84C).withOpacity(.4),
                shape: BoxShape.circle,
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
