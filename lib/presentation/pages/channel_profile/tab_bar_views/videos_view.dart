import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import 'videos_horizontal_descriptions_list.dart';

class TabBarVideosView extends StatelessWidget {
  const TabBarVideosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) => Padding(
              padding: REdgeInsetsDirectional.only(start: 15, top: 15),
              child: index == 0
                  ? const _FiltersButtons()
                  : const VideoHorizontalDescriptionsList(),
            ),
        itemCount: 20);
  }
}

class _FiltersButtons extends StatefulWidget {
  const _FiltersButtons();

  @override
  State<_FiltersButtons> createState() => _FiltersButtonsState();
}

class _FiltersButtonsState extends State<_FiltersButtons> {
  bool recentlyUploadedSelected = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () => setState(() => recentlyUploadedSelected = true),
            child: _RoundedFilteredButton(
                text: "Recently uploaded",
                isSelected: recentlyUploadedSelected)),
        const RSizedBox(width: 10),
        GestureDetector(
            onTap: () => setState(() => recentlyUploadedSelected = false),
            child: _RoundedFilteredButton(
                text: "Popular", isSelected: !recentlyUploadedSelected)),
      ],
    );
  }
}

class _RoundedFilteredButton extends StatelessWidget {
  const _RoundedFilteredButton({
    Key? key,
    required this.isSelected,
    required this.text,
  }) : super(key: key);
  final bool isSelected;

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(vertical: 8, horizontal: 13),
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
