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

  ImageProvider getProfileImage() {

    Auth auth = Provider.of<Auth>(context, listen: false);
    if (widget.client.photoURL != null) {
      return CachedNetworkImageProvider(widget.client.photoURL!);
    }  else if(auth.currentUser?.uid   == widget.client.uid && auth.tempProfilePhoto != null){
      return FileImage(auth.tempProfilePhoto!);
    }

    else {
      return const AssetImage(
          "assets/blank-profile-picture-973460_1280.webp");
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return GestureDetector(
      onTap: () async {
        await auth.changeProfilePhoto();
        setState(() {});
      },
      child: Badge.Badge(
        showBadge: auth.currentUser?.uid == widget.client.uid,
        position: Badge.BadgePosition.bottomEnd(bottom: 10, end: 10),

        badgeStyle: Badge.BadgeStyle(
          badgeColor: HexColor('#FFD700'),
        ),
        badgeContent: Icon(
          Icons.edit,
          color: HexColor("#40A49C"),
          size: 15,
        ),
        child: Container(
          height: 100.h,
          width: 100.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: getProfileImage(),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: HexColor("#40A49C"),
              width: 5,
            ),
          ),
        ),
      ),
    );
  }
}
