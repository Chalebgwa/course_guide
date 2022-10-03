import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';

class Glass extends StatelessWidget {
  Glass({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: 301.w,
        height: 120.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: Colors.red.withOpacity(.2),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 29.h,
              vertical: 26.h,
            ),
            child: child,
          )),
        ),
      ),
    );
  }
}
