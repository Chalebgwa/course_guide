import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/controllers/courses_controller.dart';
import 'package:course_guide/views/home/universities/apply_course.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../../controllers/auth.dart';

class CoursesList extends StatefulWidget {
  const CoursesList(
      {Key? key, required this.docId, required this.name, required this.image})
      : super(key: key);
  final String docId;
  final String name;
  final String image;

  @override
  State<CoursesList> createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList> {
  // create list of university courses from the list

  Stream<QuerySnapshot<Map<String, dynamic>>> getStream() {
    final auth = context.read<Auth>();
    final subjects = auth.currentUser?.results?.keys.toList()
      ?..remove("points");
    final filter = context.read<CourseController>().showFilter;

    if (filter) {
      return FirebaseFirestore.instance
          .collection("universities")
          .doc(widget.docId)
          .collection("courses")
          .where("requiredSubjects", arrayContainsAny: subjects)
          .where("minimumPoints",
              isGreaterThanOrEqualTo: auth.currentUser?.results?["points"])
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection("universities")
          .doc(widget.docId)
          .collection("courses")
          .snapshots();
    }
  }

  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<Auth>();
    final subjects = auth.currentUser?.results?.keys.toList()
      ?..remove("points");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("40A49C"),
        elevation: 0,
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Text(
          widget.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 160,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  FontAwesomeIcons.angleLeft,
                  color: Colors.white,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.image,
                  fit: BoxFit.contain,
                  width: 50,
                ),
              ),
            ],
          ),
        ),
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(50),
        //   // search bar
        //   child: Container(
        //     width: double.infinity,
        //     height: 50,
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(20),
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.grey.withOpacity(0.2),
        //           spreadRadius: 5,
        //           blurRadius: 7,
        //           offset: const Offset(0, 3), // changes position of shadow
        //         ),
        //       ],
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: TextField(
        //         controller: _searchController,
        //         onChanged: (value) {
        //           setState(() {});
        //         },
        //         decoration: InputDecoration(
        //           border: InputBorder.none,
        //           hintText: "Search",
        //           prefixIcon: const Icon(Icons.search),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text("Loading.."));
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                    "No courses within user criteria found for this university"),
              );
            }
            return CustomScrollView(
              slivers: [
                buildOther(snapshot, context)
                //buildAccordion(snapshot.data!.docs, context)
              ],
            );
          }),
    );
  }

  buildAccordion(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
      BuildContext context, name) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ExpansionTile(
          title: Text(name ?? "Uncategorized"),
          collapsedBackgroundColor: HexColor("40A49C"),
          textColor: Colors.white,
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          collapsedTextColor: Colors.white,
          backgroundColor: HexColor("40A49C"),
          children: [
            for (DocumentSnapshot<Map<String, dynamic>> doc in docs)
              buildCourseCard(context, doc)
          ],
        ),
      ),
    );
  }

  Card buildCourseCard(
      BuildContext context, DocumentSnapshot<Map<String, dynamic>> doc) {
    return Card(
      child: ListTile(
        tileColor: HexColor("#FFFFFF"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ApplyCourse(
                data: doc.data()!,
              ),
            ),
          );
        },
        // traing icon to add my list
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            doc.data()?["title"] ?? "No Title",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  buildOther(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      BuildContext context) {
    List faculties = [];
    String key = "";

    if (widget.name == "Boitekanelo College") {
      faculties = snapshot.data?.docs
              .map((e) => e.data()["department"])
              .toSet()
              .toList() ??
          [];
      key = "department";
    } else if (widget.name == "GUC") {
      key = "courseType";
      faculties =
          snapshot.data?.docs.map((e) => e.data()[key]).toSet().toList() ?? [];
      key = "courseType";
    } else {
      faculties = snapshot.data?.docs
              .map((e) => e.data()["faculty"])
              .toSet()
              .toList() ??
          [];
      key = "faculty";
    }

    return SliverList(
      delegate: SliverChildListDelegate([
        for (var f in faculties)
          buildAccordion(
              snapshot.data!.docs
                  .where((element) => element.data()[key] == f)
                  .toList(),
              context,
              f)
      ]),
    );
  }
}
