import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:video_player/video_player.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/presentation/common_widgets/custom_circle_progress.dart';
import 'package:youtube/presentation/layouts/base_layout_logic.dart';
import 'package:youtube/presentation/pages/search/search_page.dart';
import 'package:youtube/presentation/pages/shorts/logic/shorts_page_logic.dart';

part 'widgets/short_player.dart';
part 'widgets/vertical_short_widgets.dart';
part 'widgets/horizontal_short_widgets.dart';

class ShortsPage extends StatefulWidget {
  const ShortsPage({Key? key}) : super(key: key);

  @override
  ShortsPageState createState() => ShortsPageState();
}

class ShortsPageState extends State<ShortsPage> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: appBar(),
        body: const _PageViewBody(),
      ),
    );
  }

  AppBar appBar() => AppBar(
        backgroundColor: ColorManager(context).transparent,
        actions: [
          InkWell(
            onTap: () {
              Go(context).to(const SearchPage());
            },
            child: SvgPicture.asset(
              IconsAssets.search,
              height: 25,
              colorFilter:
                  const ColorFilter.mode(BaseColorManager.white, BlendMode.srcIn),
            ),
          ),
          const RSizedBox(width: 15),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.camera_alt,
                size: 30, color: ColorManager(context).white),
          ),
          const RSizedBox(width: 10),
        ],
      );
}

class _PageViewBody extends StatelessWidget {
  const _PageViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Stack(children: const [
          SizedBox(height: double.infinity, child: _ShortPlayer()),
          _HorizontalButtons(),
          _VerticalButtons(),
        ]);
      },
    );
  }
}

class _ShimmerLoading extends StatelessWidget {
  const _ShimmerLoading();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[500]!,
          highlightColor: ColorManager(context).grey6,
          child: Container(
            width: double.infinity,
            height: double.maxFinite,
            color: ColorManager(context).grey2,
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[600]!,
          highlightColor: ColorManager(context).grey6,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
                end: 25.0, bottom: 20, start: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: ColorManager(context).grey7,
                ),
                const SizedBox(height: 5),
                Container(
                    height: 15, width: 150, color: ColorManager(context).grey7),
                const SizedBox(height: 5),
                Container(
                    height: 15, width: 200, color: ColorManager(context).grey7),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
