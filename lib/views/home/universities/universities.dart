import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/views/home/home/course_list.dart';
import 'package:course_guide/views/home/universities/course_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class Universities extends StatelessWidget {
  const Universities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
            FirebaseFirestore.instance.collection("universities").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: 70.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: HexColor("#40A49C"),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      )),
                  child: Text(
                    "Universities",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return UniCard(uni: snapshot.data!.docs[index].data());
              }, childCount: snapshot.data!.docs.length))
            ],
          );
        });
  }
}

class UniCard extends StatelessWidget {
  const UniCard({Key? key, required this.uni}) : super(key: key);
  final Map<String, dynamic> uni;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 349.w,
        height: 137.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            // avatar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: NetworkImage(uni["imageUrl"]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            // name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200.w,
                    child: Text(
                      uni["name"],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200.w,
                    child: Text(
                      uni["desc"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      // filled and outlined buttons
                      ElevatedButton(
                        onPressed: () {
                          // download pdf using url_launcher
                          // launchUrl(
                          //     Uri.parse("https://www.orimi.com/pdf-test.pdf"));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CoursesList(),
                            ),
                          );
                        },
                        child: Text(
                          "Programmes",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("#40A49C"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          "Advice Forums",
                          style: TextStyle(
                            color: HexColor("#40A49C"),
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: HexColor("#40A49C"),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}