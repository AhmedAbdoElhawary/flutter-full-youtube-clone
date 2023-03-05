import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedButton extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final VoidCallback onTap;
  const RoundedButton(
      {Key? key,
      this.backgroundColor,
      required this.child,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          enableFeedback: true,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50).r),
        ),
        onPressed: onTap,
        child: child);
  }
}
