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
    return FutureBuilder(builder: ((context, snapshot) {
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
