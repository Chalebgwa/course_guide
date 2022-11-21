import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class Circles extends StatefulWidget {
  Circles({Key? key}) : super(key: key);

  @override
  State<Circles> createState() => _CirclesState();
}

class _CirclesState extends State<Circles> {
  int? _selected;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildCircle(30.w, HexColor("#40A49C"), -3),
        buildCircle(25.w, HexColor("#40A49C"), -2),
        buildCircle(20.w, HexColor("#40A49C"), -1),
        buildCircle(15.w, HexColor("#707070"), 0),
        buildCircle(20.w, HexColor("#C6F327"), 1),
        buildCircle(25.w, HexColor("#C6F327"), 2),
        buildCircle(30.w, HexColor("#C6F327"), 3),
      ],
    );
  }

  Widget buildCircle(double size, Color color, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = index;
        });
      },
      child: Container(
        width: size.toDouble(),
        height: size.toDouble(),
        decoration: BoxDecoration(
          color: _selected == index ? color : Colors.transparent,
          border: Border.all(color: color, width: 2.w),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
