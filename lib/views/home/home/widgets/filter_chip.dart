import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterChipX extends StatelessWidget {
  const FilterChipX(
      {Key? key,
      required this.icon,
      required this.text,
      required this.isSelected,
      required this.onTap})
      : super(key: key);
  final IconData icon;
  final String text;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        //margin: const EdgeInsets.only(right: 10),
        height: 42.h,
        constraints: BoxConstraints(minWidth: 100.w, maxHeight: 200.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF40A49C) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color:
                !isSelected ? const Color(0xFF40A49C) : const Color(0xFFE5E5E5),
          ),
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor:
                      isSelected ? Colors.white : const Color(0xFF40A49C),
                  radius: 14.w,
                  child: Icon(
                    icon,
                    color: !isSelected ? Colors.white : const Color(0xFF40A49C),
                    size: 14.sp,
                  ),
                ),
                const SizedBox(width: 5),
                Text(text,
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
