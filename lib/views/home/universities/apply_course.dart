import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class CourseDetailSection extends StatelessWidget {
  final String title;
  final String? content;

  const CourseDetailSection({required this.title, this.content});

  @override
  Widget build(BuildContext context) {
    if (content == null) {
      return SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            content!,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class ApplyCourse extends StatefulWidget {
  const ApplyCourse({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  State<ApplyCourse> createState() => _ApplyCourseState();
}

class _ApplyCourseState extends State<ApplyCourse> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("40A49C"),
          elevation: 0,
          toolbarHeight: 100,
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.angleLeft),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: Text(
            widget.data['title'],
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            // Header Section
            CourseDetailSection(
              title: widget.data['title'],
            ),

            // Description Section
            CourseDetailSection(
              title: 'Description',
              content: widget.data['description'],
            ),

            // What can you study Section
            CourseDetailSection(
              title: 'What can you study',
              content: widget.data['whatCanYouStudy'],
            ),

            // Modules Section (Year 1, Semester 1)
            CourseDetailSection(
              title: 'Modules Year 1, Semester 1',
              content: widget.data['modules']
                  ?.where((element) => element['Semester'] == '1')
                  .map<String>((doc) => doc['title'].toString())
                  .join(', '),
            ),

            // Modules Section (Year 1, Semester 2)
            CourseDetailSection(
              title: 'Modules Year 1, Semester 2',
              content: widget.data['modules']
                  ?.where((element) => element['Semester'] == '2')
                  .map<String>((doc) => doc['title'].toString())
                  .join(', '),
            ),

            // Requirements Section
            CourseDetailSection(
              title: 'Requirements',
              content: widget.data['requirements'],
            ),

            // Additional Info Section
            CourseDetailSection(
              title: 'Additional Info',
              content: widget.data['additionalInfo'],
            ),

            // Duration Section
            CourseDetailSection(
              title: 'Duration',
              content: widget.data['duration'],
            ),

            // Faculty Section
            CourseDetailSection(
              title: 'Faculty',
              content: widget.data['faculty'],
            ),

            // Application Fee Section
            CourseDetailSection(
              title: 'Application Fee',
              content: widget.data['applicationFee'],
            ),

            // Tuition Fee Section
            CourseDetailSection(
              title: 'Tuition Fee',
              content: widget.data['tuitionFees'],
            ),

            // Deposit Section
            CourseDetailSection(
              title: 'Deposit',
              content: widget.data['deposit'],
            ),

            // Career Opportunities Section
            CourseDetailSection(
              title: 'Career Opportunities',
              content: widget.data['careerOpportunities'],
            ),

            // Course Type Section
            CourseDetailSection(
              title: 'Course Type',
              content: widget.data['courseType'],
            ),

            // Exam Fee Section
            CourseDetailSection(
              title: 'Exam Fee',
              content: widget.data['examFee'],
            ),

            // Final Exam Fee Section
            CourseDetailSection(
              title: 'Final Exam Fee',
              content: widget.data['finalExamFee'],
            ),

            // Mid Semester Fee Section
            CourseDetailSection(
              title: 'Mid Semester Fee',
              content: widget.data['midSemesterFee'],
            ),

            // Apply Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Your existing button logic
                },
                child: const Text("Apply"),
                style: ElevatedButton.styleFrom(
                  primary: HexColor("40A49C"),
                  onPrimary: Colors.white,
                  fixedSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
