import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class FindYourConsultant extends StatefulWidget {
  const FindYourConsultant({Key? key}) : super(key: key);

  @override
  State<FindYourConsultant> createState() => _FindYourConsultantState();
}

class _FindYourConsultantState extends State<FindYourConsultant> {

  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () => context.go("/home"),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF40A49C),
                  ),
                ),
                elevation: 0,
                title: Text(
                  "Find Your Consultant",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
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
                    controller: _searchController,
                    showCursor: false,
                    onChanged: (value) {
                      setState(() {
                        
                      });
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
              // row of 3 cards with box shadow and border radius of 20 icon in center with text below]
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCard(
                              FontAwesomeIcons.brush, "Creative", "#40A49C"),
                          _buildCard(
                              FontAwesomeIcons.flask, "Medicine", "#FDE84C"),
                          _buildCard(
                              FontAwesomeIcons.brush, "Business", "#C6F327"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      buildList()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList() {
    return Container(
      // color: Colors.yellow,
      height: 300.h,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream:
              FirebaseFirestore.instance.collection('constultants').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // search through the list of consultants
            final consultants = snapshot.data!.docs.where((element) {
              final name = element.data()['name'].toString().toLowerCase();
              final searchLower = _searchController.text.toLowerCase();
              return name.contains(searchLower);
            }).toList();
            return ListView.builder(
              itemCount: consultants.length,
              itemBuilder: (context, index) {
                return _buildUser(consultants[index].data());
              },
            );
          }),
    );
  }

  Widget _buildUser(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100.h,
        width: 349.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Color(0X0000001F),
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
                height: 80.h,
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0X0000001F),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    data['imageUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 150.w,
                      child: Text(
                        data['name'],
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // clock icon
                    // const Icon(
                    //   FontAwesomeIcons.clock,
                    //   color: Color(0xFFDEDFE3),
                    //   size: 14,
                    // ),
                    SizedBox(
                      width: 21.w,
                    ),
                    SizedBox(
                      width: 60.w,
                      child: Text(
                        data['time'],
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  data['title'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // lauch phone call
                        launchUrl(Uri.parse("tel:${data['phone']}"));
                      },
                      child: Text(
                        "Book An Appointment",
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: HexColor("#40A49C"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    // call icon
                    GestureDetector(
                      onTap: () => launchUrl(Uri.parse("tel:${data['phone']}")),
                      child: Container(
                        //height: 0.h,
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: HexColor("#C6F327"),
                          //shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            FontAwesomeIcons.phoneAlt,
                            color: HexColor("#40A49C"),
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(IconData iconData, String text, String color) {
    return Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: HexColor(color),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: HexColor(color).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 40.sp,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
