import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';

class ReadMore extends StatelessWidget {
  final String text;
  final int timeLines;
  const ReadMore(this.text, {this.timeLines = 3, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: timeLines,
      colorClickableText: ColorManager(context).grey,
      trimMode: TrimMode.Line,
      trimCollapsedText: " Read more",
      trimExpandedText: " Read less",
      style: getNormalStyle(color: ColorManager(context).black, fontSize: 14),
      moreStyle:
          getNormalStyle(fontSize: 14, color: ColorManager(context).grey7),
    );
  }
}
