import 'package:flutter/material.dart';

class TextLinks extends StatelessWidget {
  const TextLinks(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
  });
  final String data;

  final TextStyle? style;

  final StrutStyle? strutStyle;

  final TextAlign? textAlign;

  final TextDirection? textDirection;

  final bool? softWrap;

  final TextOverflow? overflow;

  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      strutStyle: strutStyle,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }
}
