import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class NewList extends StatelessWidget {
  const NewList({Key? key,  required this.fitered}) : super(key: key);

  final List<String> fitered;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.h,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: fitered.isNotEmpty ? FirebaseFirestore.instance.collection('news').where("tags", arrayContainsAny: fitered).snapshots() : FirebaseFirestore.instance.collection('news').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => NewsCard(
              doc: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({Key? key, required this.doc}) : super(key: key);
  final Map<String, dynamic> doc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // show news dialog
        showDialog(
            context: context, builder: (context) => NewsDialog(doc: doc));
      },
      child: Container(
        height: 347.h,
        width: 235.w,
        decoration: BoxDecoration(
          color: const Color(0xFFFDE84C),
          borderRadius: BorderRadius.circular(20.r),
          image: DecorationImage(
            image: NetworkImage(doc['imageUrl']),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                    height: 33.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        doc['tag'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                doc['title'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              height: 75.h,
              decoration: BoxDecoration(
                  color: HexColor("#40A49C"),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  doc['description'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
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

class NewsDialog extends StatelessWidget {
  const NewsDialog({Key? key, required this.doc}) : super(key: key);
  final Map<String, dynamic> doc;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Container(
          height: 560.h,
          width: 349.w,
          decoration: BoxDecoration(
            color: const Color(0xFFFDE84C),
            borderRadius: BorderRadius.circular(20.r),
            image: DecorationImage(
              image: NetworkImage(doc['imageUrl']),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Container(
                      height: 33.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          doc['tag'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    // close button
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 33.h,
                        width: 33.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  doc['title'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                height: 392.h,
                decoration: BoxDecoration(
                    color: HexColor("#40A49C"),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    doc['description'],
                    //overflow: TextOverflow.ellipsis,
                    //maxLines: 4,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
