import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabButton extends StatefulWidget {
  const TabButton(
      {super.key,
      required this.isSelected,
      required this.icon,
      required this.text,
      required this.onTap});
  final bool isSelected;
  final Widget icon;
  final String text;
  final Function() onTap;

  @override
  State<TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<TabButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.5),
        width: widget.isSelected ? null : 60.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: widget.isSelected ? const Color(0xFFFF5858) : Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon,
                widget.isSelected
                    ? Text(
                        widget.text,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
