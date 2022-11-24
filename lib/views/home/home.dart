// import badge
import 'package:badges/badges.dart';
import 'package:course_guide/controllers/auth.dart';
import 'package:course_guide/controllers/notifications.dart';
import 'package:course_guide/models/notification_model.dart';
import 'package:course_guide/views/home/delegates/search_delegate.dart';
import 'package:course_guide/views/home/home/course_list.dart';
import 'package:course_guide/views/home/home/widgets/contact_courses.dart';
import 'package:course_guide/views/home/home/widgets/filter_chip.dart';
import 'package:course_guide/views/home/home/widgets/news_card.dart';
import 'package:course_guide/views/home/home/widgets/scholarship_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String currentPage = "Courses";
  List<String> filters = [];
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<Auth>();
    final notifications = context.watch<NotificationsController>();
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 78.h,
                //color: Colors.red,
                child: Row(
                  children: [
                    SizedBox(
                      width: 13.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hi, ${auth.currentUser?.name.split(' ')[0]}',
                          style: GoogleFonts.archivo(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF343434),
                          ),
                        ),
                        Text('Let\'s start learning!',
                            style: GoogleFonts.archivo(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF343434),
                            )),
                      ],
                    ),
                    const Spacer(),
                    // bell icon with badge yellow dot
                    // StreamBuilder<List<NotificationModel>>(
                    //     stream: notifications.getNotifications(),
                    //     builder: (context, snapshot) {
                    //       return Badge(
                    //           badgeContent: const Text(''),
                    //           badgeColor: Colors.yellow,
                    //           showBadge: snapshot.data?.isNotEmpty ?? false,
                    //           position:
                    //               BadgePosition.topEnd(top: 3.h, end: 18.w),
                    //           child: PopupMenuButton(
                    //             offset: Offset(0, 58.h),
                    //             iconSize: 44.sp,
                    //             icon: const Icon(
                    //               Icons.notifications,
                    //               color: Color(0xFF40A49C),
                    //             ),
                    //             itemBuilder: (BuildContext context) {
                    //               return [
                    //                 for (NotificationModel model
                    //                     in snapshot?.data ?? [])
                    //                   PopupMenuItem(
                    //                       child: _buildNotification(model))
                    //               ];
                    //             },
                    //           ));
                    //     }),
                    SizedBox(
                      width: 28.w,
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                width: 349.w,
                height: 50.h,
                alignment: Alignment.center,
                child: TextField(
                  showCursor: false,
                  readOnly: true,
                  onTap: () {
                    showSearch(context: context, delegate: MySearchDelegate());
                  },
                  decoration: InputDecoration(
                    enabled: true,
                    suffixIcon: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: HexColor("#40A49C"),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: const Icon(
                        FontAwesomeIcons.filter,
                        color: Colors.white,
                      ),
                    ),
                    prefix: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 14.h,
                        width: 14.w,
                        child: const Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: Color(0xFFDEDFE3),
                        ),
                      ),
                    ),
                    fillColor: const Color(0xFFF2F3F7),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        currentPage = "Courses";
                      });
                    },
                    child: Text(
                      "Courses",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: currentPage != "Courses"
                            ? HexColor("#DEDFE3")
                            : HexColor("#343434"),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        currentPage = "Scholarships";
                      });
                    },
                    child: Text(
                      "Scholarships",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: currentPage != "Scholarships"
                            ? HexColor("#DEDFE3")
                            : HexColor("#343434"),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        currentPage = "News";
                      });
                    },
                    child: Text(
                      "News",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: currentPage != "News"
                            ? HexColor("#DEDFE3")
                            : HexColor("#343434"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (currentPage == "News")
              SliverToBoxAdapter(
                  child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                runSpacing: 10.h,
                children: [
                  FilterChipX(
                      icon: FontAwesomeIcons.bookBookmark,
                      text: "For You",
                      isSelected: filters.contains("For You"),
                      onTap: () {
                        setState(() {
                          if (filters.contains("For You")) {
                            filters.remove("For You");
                          } else {
                            filters.add("For You");
                          }
                        });
                      }),
                  FilterChipX(
                      icon: FontAwesomeIcons.fire,
                      text: "Features",
                      isSelected: filters.contains("Features"),
                      onTap: () {
                        setState(() {
                          if (filters.contains("Features")) {
                            filters.remove("Features");
                          } else {
                            filters.add("Features");
                          }
                        });
                      }),
                  FilterChipX(
                      icon: FontAwesomeIcons.award,
                      text: "Top Stories",
                      isSelected: filters.contains("Top Stories"),
                      onTap: () {
                        setState(() {
                          if (filters.contains("Top Stories")) {
                            filters.remove("Top Stories");
                          } else {
                            filters.add("Top Stories");
                          }
                        });
                      }),
                ],
              )),
            if (currentPage == "Courses")
              SliverToBoxAdapter(
                  child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                runSpacing: 10.h,
                children: [
                  FilterChipX(
                      icon: FontAwesomeIcons.bookBookmark,
                      text: "Marketable",
                      isSelected: filters.contains("Marketable"),
                      onTap: () {
                        setState(() {
                          if (filters.contains("Marketable")) {
                            filters.remove("Marketable");
                          } else {
                            filters.add("Marketable");
                          }
                        });
                      }),
                  FilterChipX(
                      icon: FontAwesomeIcons.fire,
                      text: "Trending",
                      isSelected: filters.contains("Trending"),
                      onTap: () {
                        setState(() {
                          if (filters.contains("Trending")) {
                            filters.remove("Trending");
                          } else {
                            filters.add("Trending");
                          }
                        });
                      }),
                  FilterChipX(
                      icon: FontAwesomeIcons.award,
                      text: "Newest",
                      isSelected: filters.contains("Newest"),
                      onTap: () {
                        setState(() {
                          if (filters.contains("Newest")) {
                            filters.remove("Newest");
                          } else {
                            filters.add("Newest");
                          }
                        });
                      }),
                  FilterChipX(
                      icon: FontAwesomeIcons.rocket,
                      text: "Advanced",
                      isSelected: filters.contains("Advanced"),
                      onTap: () {
                        setState(() {
                          if (filters.contains("Advanced")) {
                            filters.remove("Advanced");
                          } else {
                            filters.add("Advanced");
                          }
                        });
                      }),
                ],
              )),
            if (currentPage == "Courses")
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 280.h,
                    child: CourseList(fitered: filters),
                  ),
                ),
              ),
            if (currentPage == "News")
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NewList(fitered: filters),
                ),
              ),
            if (currentPage == "Scholarships")
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Container(height: 280.h, child: const ScholarshipView()),
                ),
              ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ContactCourses(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotification(NotificationModel model) {
    return ListTile(
      title: Text(model.content),
      trailing: Icon(
        FontAwesomeIcons.eye,
        color: model.read ? Colors.grey : Colors.green,
        size: 23.sp,
      ),
    );
  }
}
