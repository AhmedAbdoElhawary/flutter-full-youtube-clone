import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';

import 'videos_horizontal_descriptions_list.dart';

class TabBarHomeView extends StatelessWidget {
  const TabBarHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) => Padding(
              padding: REdgeInsetsDirectional.only(start: 15, top: 15),
              child: index == 0
                  ? const _PopularVideosText()
                  : const VideoHorizontalDescriptionsList(),
            ),
        itemCount: 20);
  }
}

class _PopularVideosText extends StatelessWidget {
  const _PopularVideosText();

  @override
  Widget build(BuildContext context) {
    return Text("Popular videos",
        style:
            getMediumStyle(color: ColorManager(context).black, fontSize: 18));
  }
}
