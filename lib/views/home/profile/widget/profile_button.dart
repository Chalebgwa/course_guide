import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onTap,
      this.leading})
      : super(key: key);
  final String text;
  final IconData icon;
  final Function() onTap;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 349.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: const Color(0xFFFDE84C),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            // green rounded square with icon phone in yellow
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF40A49C),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(
                  icon,
                  color: Color(0xFFFDE84C),
                  size: 30,
                ),
              ),
              // green text bold "Countact Course Councilor"
            ),
            Text(
              text,
              style: TextStyle(
                color: const Color(0xFF40A49C),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            // arrow icon button
            const Spacer(),
            if (leading != null) leading!,
            if (leading == null)
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF40A49C),
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
