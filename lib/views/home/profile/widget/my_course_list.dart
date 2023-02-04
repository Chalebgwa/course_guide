import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/controllers/auth.dart';
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
                          child: ListTile(
                            textColor: Colors.white,
                            // ignore: sort_child_properties_last
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            leading: Icon(
                              Icons.book,
                              color: Colors.white,
                              size: 40,
                            ),
                            tileColor: HexColor("#40A49C"),
                            //collapsedTextColor: Colors.white,
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${doc.data()["title"]}",
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                // pop up menu with delete option
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Delete"),
                                        content: const Text(
                                            "Are you sure you want to delete this course?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel")),
                                          TextButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(auth.currentUser!.uid)
                                                    .collection('mylist')
                                                    .doc(doc.id)
                                                    .delete();
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Delete"))
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                            ),
                            //collapsedBackgroundColor: HexColor("#40A49C"),
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
