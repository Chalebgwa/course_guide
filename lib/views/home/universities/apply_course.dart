import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/controllers/auth.dart';
import 'package:course_guide/views/home/universities/guc_form/guc_form.dart';
import 'package:course_guide/views/home/universities/guc_form/guc_form_view.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
          body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          // lorem ipsum text description
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.data['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (widget.data['description'] != null)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Description",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: HexColor("40A49C"),
                    ),
                  ),
                ),
              ],
            ),
          if (widget.data['description'] != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.data['description'] ?? 'No description',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (widget.data['whatCanYouStudy'] != null)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "What can you study",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: HexColor("40A49C"),
                    ),
                  ),
                ),
              ],
            ),
          if (widget.data['whatCanYouStudy'] != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.data['whatCanYouStudy'] ?? 'No description',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (widget.data['modules'] != null)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Modules Year 1, Semester 1",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: HexColor("40A49C"),
                    ),
                  ),
                ),
              ],
            ),

          if (widget.data['modules'] != null)
            for (Map<String, dynamic> doc in widget.data['modules']
                .where((element) => element['Semester'] == "1"))
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      doc['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

          SizedBox(
            height: 20,
          ),
          if (widget.data['modules'] != null)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Modules Year 1, Semester 2",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: HexColor("40A49C"),
                    ),
                  ),
                ),
              ],
            ),

          if (widget.data['modules'] != null)
            for (Map<String, dynamic> doc in widget.data['modules']
                .where((element) => element['Semester'] == "2"))
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      doc['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              if (widget.data["requirements"] != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Requirements",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.data['requirements'] ?? 'No Requirements',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.data["additionalInfo"] != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Additional Info",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.data['additionalInfo'] ?? 'No additional info',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.data["duration"] != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Duration",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.data['duration'] ?? 'No duration',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.data["faculty"] != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Faculty",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.data['faculty'] ?? 'No faculty',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.data["applicationFee"] != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Application Fee",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.data["applicationFee"] ??
                              'No registration fee',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.data["tuitionFees"] != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Tuition Fee",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.data["tutionFees"] ?? 'No tuition fee',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.data["deposit"] != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Deposit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.data["deposit"] ?? 'No deposit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.data["careerOpportunities"] != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Career Opportunities",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.data["careerOpportunities"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.data["courseType"] != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Course Type",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.data["courseType"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              // rows for examFee, finalExamFee, midSemesterFee,
              if (widget.data["examFee"] != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Exam Fee",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.data["examFee"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.data["finalExamFee"] != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Final Exam Fee",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.data["finalExamFee"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.data["midSemesterFee"] != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Mid Semester Fee",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.data["midSemesterFee"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HexColor("40A49C"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          //SzieBox
          SizedBox(
            height: 40,
          ),

          // button to apply
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final auth = Provider.of<Auth>(context, listen: false);
                // add to my courses
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(auth.currentUser?.uid)
                    .collection("mylist")
                    .doc(widget.data['title'])
                    .set(widget.data);

                await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Success"),
                          content: Text(
                              "Course added to your list, you can now apply for this course"),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("OK"))
                          ],
                        ));
                final uni = context.read<GucForm>().currentCourse;
                final pdf = context.read<GucForm>().url;
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
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("OK"))
                              ],
                            ));
                  }
                }
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
      )),
    );
  }
}
