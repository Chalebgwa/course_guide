import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/controllers/auth.dart';
import 'package:course_guide/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class AdviceForums extends StatefulWidget {
  AdviceForums({Key? key, required this.docId}) : super(key: key);
  final String docId;

  @override
  State<AdviceForums> createState() => _AdviceForumsState();
}

class _AdviceForumsState extends State<AdviceForums> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<Auth>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Advice Forums"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("universities")
              .doc(widget.docId)
              .collection("advice_forums")
              .where("status", isEqualTo: "approved")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return AdviceForumCard(
                            adviceForum: snapshot.data!.docs[index].data());
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Comment",
                      prefixIcon: Icon(Icons.comment),
                      suffixIcon: IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("universities")
                              .doc(widget.docId)
                              .collection("advice_forums")
                              .add({
                            "comment": _searchController.text,
                            "user": auth.currentUser!.toMap(),
                            "date": DateTime.now(),
                            "status": "pending"
                          });

                          _searchController.clear();
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.blue,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}

class AdviceForumCard extends StatelessWidget {
  const AdviceForumCard({Key? key, required this.adviceForum})
      : super(key: key);
  final Map<String, dynamic> adviceForum;

  @override
  Widget build(BuildContext context) {
    final user = Client.fromMap(adviceForum["user"]);

    return Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL ??
                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(user.name),
            ),
            subtitle: Text(adviceForum["comment"]),
            isThreeLine: true,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  timeago.format(adviceForum["date"].toDate()),
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
