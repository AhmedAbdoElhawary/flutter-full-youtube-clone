import 'package:flutter/material.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/styles_manager.dart';

class SubscribeButton extends StatelessWidget {
  final double fontSize;
  const SubscribeButton({this.fontSize=17,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {

      },
      child: Text(
        "SUBSCRIBE",
        style: getMediumStyle(color: ColorManager.blackRed, fontSize: fontSize),
      ),
    );
  }
}
