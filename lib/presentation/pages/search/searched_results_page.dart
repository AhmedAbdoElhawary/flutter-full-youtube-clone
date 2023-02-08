import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube/presentation/pages/search/widgets/searched_text_field.dart';
import 'package:youtube/presentation/widgets/moved_thumbnail_video.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import 'widgets/mic_button.dart';

class SearchedResultsPage extends StatelessWidget {
  const SearchedResultsPage({required this.text, Key? key}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: text);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5.w,
        surfaceTintColor: ColorManager(context).white,
        title: SearchTextField(controller: controller,enableOnTap: true),
        actions: [
          const RSizedBox(width: 15),
          const MicIconButton(),
          const RSizedBox(width: 20),
          SvgPicture.asset(IconsAssets.menuPointsVerticalIcon, height: 15),
          const RSizedBox(width: 20),
        ],
      ),
      body: ListView.builder(
          itemBuilder: (context, index) => Padding(
                padding: REdgeInsets.only(bottom: 15),
                child: MovedThumbnailVideo(index),
              ),
          itemCount: 50),
    );
  }
}
