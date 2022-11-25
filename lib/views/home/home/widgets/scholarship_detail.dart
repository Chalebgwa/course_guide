import 'package:course_guide/models/scholarships.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ScholarshipDetail extends StatelessWidget {
  const ScholarshipDetail({Key? key, required this.scholarships})
      : super(key: key);

  final Scholarships scholarships;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              scholarships.image,
              fit: BoxFit.cover,
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(scholarships.title),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(scholarships.description),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    launchUrl(
                      Uri.parse(scholarships.link),
                    );
                  },
                  child: Text(
                    "Apply",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(fixedSize: Size(200.w, 40.h)),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
