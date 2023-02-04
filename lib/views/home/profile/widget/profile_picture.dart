import 'package:badges/badges.dart' as Badge;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/controllers/auth.dart';
import 'package:course_guide/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key? key, required this.client}) : super(key: key);
  final Client client;

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: CircleAvatar(
        backgroundColor: HexColor("#40A49C"),
        child: GestureDetector(
          onTap: () async {
            await auth.changeProfilePhoto();
            setState(() {});
          },
          child: Badge.Badge(
            showBadge: auth.currentUser?.uid == widget.client.uid,
            position: Badge.BadgePosition.bottomEnd(bottom: 0, end: 0),
            badgeColor: HexColor('#FFD700'),
            badgeContent: Icon(
              Icons.edit,
              color: HexColor("#40A49C"),
              size: 15,
            ),
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(auth.currentUser?.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || auth.isloading) {
                    return Image.asset(
                      "assets/blank-profile-picture-973460_1280.webp",
                      fit: BoxFit.cover,
                    );
                  }

                  final client = Client.fromMap(snapshot.data!.data()!);

                  return Container(
                    width: 100,
                    height: 100,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: HexColor("#40A49C"),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: client.photoURL != null
                          ? CachedNetworkImage(
                              imageUrl: client.photoURL!,
                              placeholder: (context, url) => Image.asset(
                                    "assets/blank-profile-picture-973460_1280.webp",
                                    fit: BoxFit.cover,
                                  ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover)
                          : Image.asset(
                              "assets/blank-profile-picture-973460_1280.webp",
                            ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
