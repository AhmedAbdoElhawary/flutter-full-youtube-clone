import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';

class RoundedFilteredButton extends StatelessWidget {
  const RoundedFilteredButton({
    Key? key,
    required this.isSelected,
    required this.text,
  }) : super(key: key);
  final bool isSelected;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(vertical: 10, horizontal: 13),
      decoration: BoxDecoration(
          color: isSelected
              ? ColorManager(context).black
              : ColorManager(context).grey1,
          borderRadius: BorderRadius.circular(20.r)),
      child: Text(
        text,
        style: getNormalStyle(
            color: isSelected
                ? ColorManager(context).white
                : ColorManager(context).black,
            fontSize: 13),
      ),
    );
  }
}
