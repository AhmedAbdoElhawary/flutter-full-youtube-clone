import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/videos_details/video_details_extension.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/presentation/common_widgets/custom_circle_progress.dart';
import 'package:youtube/presentation/common_widgets/error_message_widget.dart';
import 'package:youtube/presentation/common_widgets/thumbnail_image.dart';
import 'package:youtube/presentation/cubit/channel/channel_videos/channel_videos_cubit.dart';
import 'package:youtube/presentation/layouts/base_layout_logic.dart';
import 'package:youtube/presentation/pages/channel_profile/channel_profile_logic.dart';
import 'package:youtube/presentation/pages/channel_profile/widgets/rounded_filtered_button.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';
import 'package:youtube/presentation/pages/shorts/shorts_page.dart';
import '../../../../core/resources/color_manager.dart';

class TabBarShortVideosView extends StatefulWidget {
  const TabBarShortVideosView(this.channelDetails, {Key? key})
      : super(key: key);
  final ChannelDetailsItem? channelDetails;

  @override
  State<TabBarShortVideosView> createState() => _TabBarShortVideosViewState();
}

class _TabBarShortVideosViewState extends State<TabBarShortVideosView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const _FiltersButtons(),
        GetBuilder<ChannelProfileLogic>(
          tag: "1",
          id: "update-channel-short-videos",
          builder: (controller) {
            return controller.getRecentlyShortVideosSelected
                ? _NewestShortVideos(widget.channelDetails)
                : _PopularShortVideos(widget.channelDetails);
          },
        )
      ],
    );
  }
}

class _PopularShortVideos extends StatelessWidget {
  const _PopularShortVideos(this.channelDetails);

  final ChannelDetailsItem? channelDetails;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelVideosCubit, ChannelVideosState>(
      bloc: ChannelVideosCubit.get(context)
        ..getPopularChannelShortVideos(channelDetails?.id ?? ""),
      buildWhen: (previous, current) =>
          previous != current && current is ShortPopularVideosLoaded,
      builder: (context, state) {
        if (state is ShortPopularVideosLoaded) {
          return _ShortVideosGridView(state.videoDetails);
        } else if (state is ChannelError) {
          return SliverFillRemaining(
              child: ErrorMessageWidget(state.networkExceptions));
        } else {
          return const SliverFillRemaining(child: ThineCircularProgress());
        }
      },
    );
  }
}

class _NewestShortVideos extends StatelessWidget {
  const _NewestShortVideos(this.channelDetails);

  final ChannelDetailsItem? channelDetails;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelVideosCubit, ChannelVideosState>(
      bloc: ChannelVideosCubit.get(context)
        ..getChannelShortVideos(channelDetails?.id ?? ""),
      buildWhen: (previous, current) =>
          previous != current && current is ShortVideosLoaded,
      builder: (context, state) {
        if (state is ShortVideosLoaded) {
          return _ShortVideosGridView(state.videoDetails);
        } else if (state is ChannelError) {
          return SliverFillRemaining(
              child: ErrorMessageWidget(state.networkExceptions));
        } else {
          return const SliverFillRemaining(child: ThineCircularProgress());
        }
      },
    );
  }
}

class _ShortVideosGridView extends StatelessWidget {
  const _ShortVideosGridView(this.videoDetails);
  final VideosDetails videoDetails;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: REdgeInsets.symmetric(horizontal: 1.5),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) =>
              _BuildGridItem(videoDetails.videoDetailsItem!, index),
          childCount: videoDetails.videoDetailsItem?.length ?? 0,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 9 / 15,
          crossAxisSpacing: 1.7,
          mainAxisSpacing: 1.5,
        ),
      ),
    );
  }
}

class _BuildGridItem extends StatelessWidget {
  const _BuildGridItem(this.videoDetailsItem, this.index);
  final int index;
  final List<VideoDetailsItem> videoDetailsItem;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<MiniVideoViewLogic>(tag: "1").showFloatingVideo = false;
        Get.find<BaseLayoutLogic>(tag: "1").setIsShortsPageSelected= true;
        Go(context).to(ShortsPage(
          parameters: ShortsPageParameters(videoDetailsItem: videoDetailsItem),
        ));
      },
      child: ThumbnailImage(
        videoDetailsItem[index].getVideoThumbnails(),
        childAboveImage: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            "${videoDetailsItem[index].getVideoViewsCount()} views",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getNormalStyle(color: BaseColorManager.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}

class _FiltersButtons extends StatefulWidget {
  const _FiltersButtons();

  @override
  State<_FiltersButtons> createState() => _FiltersButtonsState();
}

class _FiltersButtonsState extends State<_FiltersButtons> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChannelProfileLogic>(
      tag: "1",
      id: "update-channel-short-videos",
      builder: (logic) {
        return SliverToBoxAdapter(
          child: Padding(
            padding:
                REdgeInsetsDirectional.only(start: 15, top: 15, bottom: 15),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () => logic.isRecentlyShortVideosSelected = true,
                    child: RoundedFilteredButton(
                        text: "Recently uploaded",
                        isSelected: logic.getRecentlyShortVideosSelected)),
                const RSizedBox(width: 10),
                GestureDetector(
                    onTap: () => logic.isRecentlyShortVideosSelected = false,
                    child: RoundedFilteredButton(
                        text: "Popular",
                        isSelected: !logic.getRecentlyShortVideosSelected)),
              ],
            ),
          ),
        );
      },
    );
  }
}
