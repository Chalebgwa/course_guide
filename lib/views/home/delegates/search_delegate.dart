// search delegate
import 'package:course_guide/controllers/search_controller.dart';
import 'package:course_guide/models/course.dart';
import 'package:course_guide/models/scholarships.dart';
import 'package:course_guide/models/user.dart';
import 'package:course_guide/views/courses/course_view.dart';
import 'package:course_guide/views/home/home/widgets/scholarship_detail.dart';
import 'package:course_guide/views/profile/user_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// controllers

class MySearchDelegate extends SearchDelegate<String> {
  get recentSuggest => [];
  dynamic selectedResult;

  get searchList => [];

  String getImageUrl(dynamic result) {
    if (result is Course) {
      return result.imageUrl;
    } else if (result is Scholarships) {
      return result.image;
    }
    return "";
  }

  String getType(dynamic result) {
    if (result is Course) {
      return "Course";
    } else if (result is Scholarships) {
      return "Scholarship";
    } else if (result is Client) {
      return "User";
    } else {
      return "Unknown";
    }
  }

  // search delegate
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  // search delegate
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  // search delegate
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(query),
      ),
    );
  }

  // search delegate
  @override
  Widget buildSuggestions(BuildContext context) {
    final controller = SearchController();

    final searchFunctin = controller.search(query);

    return FutureBuilder(
      future: searchFunctin,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    getImageUrl(
                      snapshot.data[index],
                    ),
                    
                  ),
                ),
                onTap: () {
                  selectedResult = snapshot.data[index];
                  showResults(context);
                },
                title: Text(snapshot.data[index].toString()),
                subtitle: Text(getType(snapshot.data[index])),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

    // return ListView.builder(
    //   itemCount: suggestionList.length,
    //   itemBuilder: (context, index) => ListTile(
    //     onTap: () {
    //       query = suggestionList[index];
    //       showResults(context);
    //     },
    //     title: RichText(t
    //       text: TextSpan(
    //         text: suggestionList[index].toString(),
    //         style: TextStyle(
    //           color: Colors.black,
    //           fontWeight: FontWeight.bold,
    //         ),
    //         children: [
    //           TextSpan(
    //             text: suggestionList[index].substring(query.length),
    //             style: TextStyle(color: Colors.grey),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  @override
  void showResults(BuildContext context) {
    // check if selected result is a user
    if (selectedResult is Scholarships) {
      // navigate to user profile
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return ScholarshipDetail(
            scholarships: selectedResult,
          );
        },
      ));
    }
    // check if selected result is a course
    if (selectedResult is Course) {
      // navigate to course view
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return CourseView(
            course: selectedResult,
          );
        },
      ));
    }
  }
}
