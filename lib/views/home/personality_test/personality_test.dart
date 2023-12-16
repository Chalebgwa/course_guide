import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/controllers/mbti_controller.dart';
import 'package:course_guide/util/mbti_types.dart';
import 'package:course_guide/views/home/home/course_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonalityTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mbtiProvider = Provider.of<MBTIController>(context);
    final question = mbtiProvider.currentQuestion;

    if (mbtiProvider.completedTest) {
      return FutureBuilder(
        future: mbtiProvider.getCourses(),
        builder: (context, snaphot) {
          if (snaphot.connectionState == ConnectionState.waiting ||
              !snaphot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snaphot.data!.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              mbtiProvider.resetTest();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    CachedNetworkImage(
                      imageUrl:
                          mbtiTypes[mbtiProvider.personalityType]!["image"],
                      height: 150.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Your personality type is ${mbtiProvider.personalityType}!",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        mbtiTypes[mbtiProvider.personalityType]!["summary"],
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Career Options",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                );
              }

              return CourseCard(course: snaphot.data![index - 1]);
            },
          );
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('MBTI Quiz'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '.${mbtiProvider.currentQuestionIndex}.',
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 16),
              Container(
                alignment: Alignment.center,
                height: 230.h,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    question["Q${mbtiProvider.currentQuestionIndex}"],
                    style: TextStyle(fontSize: 28.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 32.sp),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (MapEntry q in question['answers'].entries)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          mbtiProvider.updateAnswer(
                            q.key,
                          );
                        },
                        splashColor: Theme.of(context).colorScheme.secondary,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          constraints: BoxConstraints(
                            minHeight: 40.h,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${q.key}:  ${q.value}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  // ElevatedButton(
                  //   onPressed: () {
                  //     mbtiProvider.updateAnswer(
                  //       q.key,
                  //     );
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     //primary: Colors.blue,
                  //     fixedSize: Size(300, 40),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  //   child: Text(
                  //     q.value,
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //       fontSize: 12,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
