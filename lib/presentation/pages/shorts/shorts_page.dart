import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/presentation/common_widgets/arrow_back.dart';
import 'package:youtube/presentation/common_widgets/error_message_widget.dart';
import 'package:youtube/presentation/cubit/videos/videos_details_cubit.dart';
import 'package:youtube/presentation/pages/shorts/widgets/shorts_page_view.dart';

class ShortsPageParameters {
  final List<VideoDetailsItem>? videoDetailsItem;

  ShortsPageParameters({this.videoDetailsItem});
}

class ShortsPage extends StatefulWidget {
  const ShortsPage({this.parameters, Key? key}) : super(key: key);
  final ShortsPageParameters? parameters;
  @override
  ShortsPageState createState() => ShortsPageState();
}

class ShortsPageState extends State<ShortsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: BaseColorManager.black87,
        body: SafeArea(
          child: widget.parameters?.videoDetailsItem != null
              ? BodyWithAppBar(
                  child: ShortsPageView(widget.parameters?.videoDetailsItem))
              : const BodyWithAppBar(
                  showArrowBack: false, child: _PageViewBody()),
        ),
      ),
    );
  }
}

class BodyWithAppBar extends StatelessWidget {
  final Widget child;
  final bool showArrowBack;
  const BodyWithAppBar(
      {this.showArrowBack = true, required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        child,
        Row(
          children: [
            if (showArrowBack) const ArrowBack(makeItWhite: true),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt,
                  size: 30, color: BaseColorManager.white),
            ),
            const RSizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}

class _PageViewBody extends StatelessWidget {
  const _PageViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideosDetailsCubit, VideosDetailsState>(
      bloc: VideosDetailsCubit.get(context)..getAllShortVideos(),
      buildWhen: (previous, current) =>
          previous != current && current is AllShortVideosLoaded,
      builder: (context, state) {
        if (state is AllShortVideosLoaded) {
          return ShortsPageView(state.mostPopularVideos.videoDetailsItem);
        } else if (state is VideoError) {
          return ErrorMessageWidget(state.networkExceptions);
        } else {
          return const _ShimmerLoading();
        }
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
          baseColor: Colors.grey[800]!,
          highlightColor: ColorManager(context).grey9,
          child: Container(
            width: double.infinity,
            height: double.maxFinite,
            color: ColorManager(context).grey8,
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[800]!,
          highlightColor: ColorManager(context).grey9,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
                end: 25.0, bottom: 20, start: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: ColorManager(context).grey8,
                ),
                const SizedBox(height: 5),
                Container(
                    height: 15, width: 150, color: ColorManager(context).grey8),
                const SizedBox(height: 5),
                Container(
                    height: 15, width: 200, color: ColorManager(context).grey8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
