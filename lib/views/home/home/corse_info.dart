import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/controllers/auth.dart';
import 'package:course_guide/models/course.dart';
import 'package:course_guide/views/home/universities/guc_form/guc_form_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseInfo extends StatelessWidget {
  const CourseInfo({Key? key, required this.course}) : super(key: key);
  final Course course;

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUniversity() async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('universities')
            .doc(course.uniId)
            .get();
    return documentSnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: course.id ?? course,
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
              image: course.imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(course.imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
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
                          course.state ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // x button
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
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
                  Text(course.title ?? "",
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
                        onPressed: () async {
                          final auth =
                              Provider.of<Auth>(context, listen: false);
                          // add to my courses
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(auth.currentUser?.uid)
                              .collection("mylist")
                              .doc(course.title)
                              .set(course.toJson());
                          final university = await getUniversity();

                          if (university != null) {
                            final uni = university.data()?['name'];
                            final pdf = university.data()?['pdf'];

                            if (uni == "GUC") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const GucFormView(),
                                ),
                              );
                            } else {
                              if (pdf != null) {
                                launchUrl(Uri.parse(pdf),
                                    mode: LaunchMode.externalApplication);
                              } else {
                                // show pdf not found
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Oops"),
                                    content: Text(
                                        "Application form is not available for this university"),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("OK"))
                                    ],
                                  ),
                                );
                              }
                            }
                          }
                        },
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
                  if (course.description != null)
                    Text(
                      course.description!,
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
