import 'package:course_guide/controllers/courses_controller.dart';
import 'package:course_guide/models/course.dart';
import 'package:course_guide/views/home/home/corse_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CourseList extends StatelessWidget {
  const CourseList({Key? key, required this.fitered}) : super(key: key);
  final List<String> fitered;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Course>>(
        stream: CourseController().streamCourses(fitered),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data?.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CourseCard(
                course: snapshot.data![index],
              );
            },
          );
        });
  }
}

// card

class CourseCard extends StatelessWidget {
  const CourseCard({Key? key, required this.course}) : super(key: key);
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // show course info as dialog
          showDialog(
              context: context,
              builder: (context) {
                return CourseInfo(course: course);
              });
        },
        child: Hero(
          tag: course.id,
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
                  Spacer(),
                  Text(course.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.solidUser,
                        color: Colors.white,
                        size: 10.sp,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${course.enrolled} Enrolled",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Icon(
                        FontAwesomeIcons.graduationCap,
                        color: Colors.white,
                        size: 10.sp,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${course.graduated} Graduated}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
