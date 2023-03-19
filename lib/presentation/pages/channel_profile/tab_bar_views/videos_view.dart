import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/presentation/common_widgets/error_message_widget.dart';
import 'package:youtube/presentation/common_widgets/horizontal_videos_loading.dart';
import 'package:youtube/presentation/cubit/channel/channel_videos/channel_videos_cubit.dart';
import 'package:youtube/presentation/pages/channel_profile/channel_profile_logic.dart';
import 'package:youtube/presentation/pages/channel_profile/widgets/rounded_filtered_button.dart';
import 'videos_horizontal_descriptions_list.dart';

class TabBarVideosView extends StatefulWidget {
  const TabBarVideosView(this.channelDetails, {Key? key}) : super(key: key);
  final ChannelDetailsItem? channelDetails;

  @override
  State<TabBarVideosView> createState() => _TabBarVideosViewState();
}

class _TabBarVideosViewState extends State<TabBarVideosView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const _FiltersButtons(),
        GetBuilder<ChannelProfileLogic>(
          tag: "1",
          id: "update-channel-videos",
          builder: (controller) {
            return controller.getRecentlyVideosSelected
                ? _NewestVideos(widget.channelDetails)
                : _PopularVideos(widget.channelDetails);
          },
        )
      ],
    );
  }
}

class _PopularVideos extends StatelessWidget {
  const _PopularVideos(this.channelDetails);

  final ChannelDetailsItem? channelDetails;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelVideosCubit, ChannelVideosState>(
      bloc: ChannelVideosCubit.get(context)
        ..getPopularChannelVideos(channelDetails?.id ?? ""),
      buildWhen: (previous, current) =>
          previous != current && current is PopularVideosLoaded,
      builder: (context, state) {
        if (state is PopularVideosLoaded) {
          return _VideosList(state.videoDetails);
        } else if (state is ChannelError) {
          return SliverFillRemaining(
              child: ErrorMessageWidget(state.networkExceptions));
        } else {
          return const SliverHorizontalVideosShimmerLoading();
        }
      },
    );
  }
}

class _NewestVideos extends StatelessWidget {
  const _NewestVideos(this.channelDetails);

  final ChannelDetailsItem? channelDetails;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelVideosCubit, ChannelVideosState>(
      bloc: ChannelVideosCubit.get(context)
        ..getChannelVideos(channelDetails?.id ?? ""),
      buildWhen: (previous, current) =>
          previous != current && current is ChannelVideosLoaded,
      builder: (context, state) {
        if (state is ChannelVideosLoaded) {
          return _VideosList(state.videoDetails);
        } else if (state is ChannelError) {
          return SliverFillRemaining(
              child: ErrorMessageWidget(state.networkExceptions));
        } else {
          return const SliverHorizontalVideosShimmerLoading();
        }
      },
    );
  }
}

class _VideosList extends StatelessWidget {
  const _VideosList(this.videoDetails);
  final VideosDetails videoDetails;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: videoDetails.videoDetailsItem?.length ?? 0,
        (context, index) => Padding(
          padding: REdgeInsetsDirectional.only(start: 15, top: 15),
          child: VideoHorizontalDescriptionsList(
              videoDetails.videoDetailsItem![index]),
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
      id: "update-channel-videos",
      builder: (controller) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: REdgeInsetsDirectional.only(start: 15, top: 15),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () => controller.isRecentlyVideosSelected = true,
                    child: RoundedFilteredButton(
                        text: "Recently uploaded",
                        isSelected: controller.getRecentlyVideosSelected)),
                const RSizedBox(width: 10),
                GestureDetector(
                    onTap: () => controller.isRecentlyVideosSelected = false,
                    child: RoundedFilteredButton(
                        text: "Popular",
                        isSelected: !controller.getRecentlyVideosSelected)),
              ],
            ),
          ),
        );
      },
    );
  }
}
