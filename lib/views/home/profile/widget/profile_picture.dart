import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/controllers/auth.dart';
import 'package:course_guide/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
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
      height: 118.h,
      width: 118.w,
      child: CircleAvatar(
        backgroundColor: HexColor("#40A49C"),
        child: GestureDetector(
          onTap: () async {
            await auth.changeProfilePhoto();
            setState(() {});
          },
          child: Badge(
            showBadge: auth.currentUser?.uid == widget.client.uid,
            position: BadgePosition.bottomEnd(bottom: 0, end: 0),
            badgeColor: HexColor('#FFD700'),
            badgeContent: Icon(
              Icons.edit,
              color: HexColor("#40A49C"),
              size: 15,
            ),
            child: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
              future: FirebaseFirestore.instance.collection('users')
                  .doc(auth.currentUser?.uid)
                  .get(),


              builder: (context, snapshot) {
               
               if(!snapshot.hasData || auth.isloading){
                 return Center(child: const CircularProgressIndicator());
                }


                final client = Client.fromMap(snapshot.data!.data()!);

                
                return CircleAvatar(
                  radius: 50,
                  backgroundImage: client.photoURL != null
                      ? Image.network(
                          client.photoURL!,
                          
                        ).image 
                      : AssetImage("assets/blank-profile-picture-973460_1280.webp"),
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
