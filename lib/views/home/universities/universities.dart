import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/views/home/universities/advice_forums.dart';
import 'package:course_guide/views/home/universities/course_list.dart';
import 'package:course_guide/views/home/universities/guc_form/guc_form.dart';
import 'package:course_guide/views/home/universities/unipage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

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
      child: GestureDetector(
        onTap: () {
          final docId = uni["docId"];

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Unipage(
                uni: uni,
              ),
            ),
          );
        },
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
                  width: 100.h,
                  height: 100.h,
                  child: Container(
                    width: 100.h,
                    height: 100.h,
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        FontAwesomeIcons.eye,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(uni["imageUrl"]),
                      fit: BoxFit.contain,
                    ),
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
                            final docId = uni["docId"];
                            context
                                .read<GucForm>()
                                .changeCurrentCourse(uni["name"]);
                            context.read<GucForm>().changeUrl(uni["pdf"]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CoursesList(
                                  docId: docId,
                                  name: uni["name"],
                                  image: uni["imageUrl"],
                                ),
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
                          onPressed: () {
                            final docId = uni["docId"];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AdviceForums(docId: docId),
                              ),
                            );
                          },
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
      ),
    );
  }
}
