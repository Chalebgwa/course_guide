import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/controllers/auth.dart';
import 'package:course_guide/models/db_init.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
// video player
import 'package:video_player/video_player.dart';

class MyCourseList extends StatefulWidget {
  const MyCourseList({Key? key}) : super(key: key);

  @override
  State<MyCourseList> createState() => _MyCourseListState();
}

class _MyCourseListState extends State<MyCourseList> {
  // video controller
  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // video controller
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  void toggleVideo() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<Auth>();
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('mylist')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  for (var doc in snapshot.data!.docs)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ExpansionTile(
                            textColor: Colors.white,
                            // ignore: sort_child_properties_last
                            children: [
                              // if(doc.data().containsKey("modules"))
                              // for(Map<String,dynamic> doc2 in data[0]["modules"])
                              // ListTile(
                              //   title: Text(doc2["title"]),
                              //   subtitle: Text("0"),
                              //   trailing: IconButton(
                              //     onPressed: () {
                              //       toggleVideo();
                              //     },
                              //     icon: Icon(
                              //       _controller.value.isPlaying
                              //           ? Icons.pause
                              //           : Icons.play_arrow,
                              //     ),
                              //   ),
                              
                              // )

                           
                              
                              // _controller.value.isInitialized ? ClipRRect(
                              //   child: SizedBox(
                              //     height: 300,
                              //     width: 400,
                              //     child: VideoPlayer(_controller),
                              //   ),
                              // ) : Container(), 
                            ],
                            leading: Icon(
                              Icons.book,
                              color: Colors.white,
                            ),
                            backgroundColor: HexColor("#40A49C"),
                            collapsedTextColor: Colors.white,
                            title: Text(
                              "${doc.data()["title"]}",
                            ),
                            collapsedBackgroundColor: HexColor("#40A49C"),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
        });
  }
}
