import 'package:flutter/material.dart';

class BackgroundImages extends StatefulWidget {
  const BackgroundImages({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<BackgroundImages> createState() => _BackgroundImagesState();
}

class _BackgroundImagesState extends State<BackgroundImages> {
  @override
  Widget build(BuildContext context) {
    // load images from firebase storage
    return FutureBuilder(
        future: Future.value(
            'https://firebasestorage.googleapis.com/v0/b/college-app-1f9e0.appspot.com/o/college%2F${widget.id}%2Fbackground.jpg?alt=media&token=8b4b5b1e-5b1e-4b9e-9b9e-4b9e9b9e4b9e'),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(snapshot.data.toString()),
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }
}
