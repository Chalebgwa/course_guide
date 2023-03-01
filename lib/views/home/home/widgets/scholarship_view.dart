import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/models/scholarships.dart';
import 'package:course_guide/views/home/home/widgets/scholarship_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class ScholarshipView extends StatefulWidget {
  const ScholarshipView({Key? key}) : super(key: key);

  @override
  State<ScholarshipView> createState() => _ScholarshipViewState();
}

class _ScholarshipViewState extends State<ScholarshipView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
            FirebaseFirestore.instance.collection('scholarships').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return SizedBox(
            height: 350.h,
            width: 440.w,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var doc in snapshot.data!.docs) _buildCard(doc.data())
              ],
            ),
          );
        });
  }

  Widget _buildCard(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 250.w,
        height: 390.h,
        decoration: BoxDecoration(
          color: HexColor("#40A49C"),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.r),
                ),
                width: 300.w,
                height: 160.h,
                child: CachedNetworkImage(
                  imageUrl: data['imageUrl'],
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Center(
                      child: Icon(
                        FontAwesomeIcons.graduationCap,
                        color: Colors.white,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: HexColor("#FFFFFF"),
                    fontSize: 14.sp,
                  ),
                ),
              ),
              // apply button
              ElevatedButton(
                onPressed: () {
                  final scholarship = Scholarships.fromJson(data);

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ScholarshipDetail(
                      scholarships: scholarship,
                    );
                  }));
                },
                child: Text(
                  'Apply',
                ),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    Size(200.w, 30.h),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor:
                      MaterialStateProperty.all(HexColor("#40A49C")),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
