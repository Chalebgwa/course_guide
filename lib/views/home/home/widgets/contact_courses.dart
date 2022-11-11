import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ContactCourses extends StatelessWidget {
  const ContactCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/consultants'),
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
                child: const Icon(
                  Icons.phone,
                  color: Color(0xFFFDE84C),
                  size: 30,
                ),
              ),
              // green text bold "Countact Course Councilor"
            ),
            Text(
              "Contact Course Councilor",
              style: TextStyle(
                color: const Color(0xFF40A49C),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            // arrow icon button
            const Spacer(),
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
