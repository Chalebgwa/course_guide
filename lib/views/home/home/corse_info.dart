import 'package:course_guide/models/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class CourseInfo extends StatelessWidget {
  const CourseInfo({Key? key, required this.course}) : super(key: key);
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: course.id,
      child: Padding(
        padding:
            EdgeInsets.only(top: 142.h, bottom: 65.h, left: 20.w, right: 20.w),
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 280.h,
            width: 235.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              image: DecorationImage(
                image: NetworkImage(course.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 79.w,
                        height: 33.h,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          course.state,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // x button
                      Spacer(),
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                     
                      }, icon: Icon(
                          FontAwesomeIcons.times,
                          color: Colors.white,
                          size: 12.sp,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(course.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      )),
                  Spacer(),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text("Course Details",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          )),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Enroll Now",
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: HexColor("#40A49C"),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  Text(
                    course.description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
