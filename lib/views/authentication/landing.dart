import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/04.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(.6),
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            Image.asset(
              'assets/logo.png',
              height: 300.h,
              width: 300.w,
            ),
            const SizedBox(
              height: 20,
            ),
            // sign in button
            ElevatedButton(
              onPressed: () {
                context.go('/sign-up');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: HexColor("#40A49C"),
                fixedSize: Size(240.w, 50.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text("Sign Up"),
            ),
            const SizedBox(
              height: 20,
            ),
            // outline button
            OutlinedButton(
              onPressed: () {
                context.go('/sign-in');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                side: const BorderSide(
                  color: Colors.white,
                  width: 2,
                ),
                fixedSize: Size(240.w, 50.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(
                    color: Colors.white,
                    width: 20,
                  ),
                ),
              ),
              child: const Text("Log In"),
            ),
          ],
        ),
      ),
    );
  }
}
