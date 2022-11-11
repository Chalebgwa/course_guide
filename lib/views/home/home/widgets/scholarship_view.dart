import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class ScholarshipView extends StatelessWidget {
  const ScholarshipView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
            FirebaseFirestore.instance.collection('scholarships').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            children: [
              for (var doc in snapshot.data!.docs) _buildCard(doc.data())
            ],
          );
        });
  }

  Widget _buildCard(Map<String, dynamic> data) {
    return Container(
      width: 161.w,
      height: 250.h,
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
                color: HexColor("#FDE84C"),
                borderRadius: BorderRadius.circular(10.r),
              ),
              width: double.infinity,
              height: 86.h,
              child: Image.network(
                data['imageUrl'],
                fit: BoxFit.cover,
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
              onPressed: () {},
              child: Text(
                'Apply',
              ),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  Size(142.w, 30.h),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(HexColor("#40A49C")),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
