
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube/core/utility/constants.dart';

class ThineCircularProgress extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  final double strokeWidth;
  final Animation<Color?>? valueColor;

  const ThineCircularProgress(
      {Key? key,
        this.strokeWidth = 3.0,
        this.backgroundColor,
        this.color,
        this.valueColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isThatAndroid
          ? CircularProgressIndicator(
          backgroundColor: backgroundColor,
          valueColor: valueColor,
          strokeWidth: strokeWidth,
          color: color ?? Theme.of(context).focusColor)
          : CupertinoActivityIndicator(
          color: color ?? Theme.of(context).focusColor),
    );
  }
}
