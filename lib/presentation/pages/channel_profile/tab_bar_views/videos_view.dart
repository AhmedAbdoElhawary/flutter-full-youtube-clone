import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/presentation/common_widgets/custom_circle_progress.dart';
import 'package:youtube/presentation/cubit/channel/channel_videos/channel_videos_cubit.dart';
import 'package:youtube/presentation/pages/channel_profile/channel_profile_logic.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import 'videos_horizontal_descriptions_list.dart';

class TabBarVideosView extends StatefulWidget {
  const TabBarVideosView(this.channelDetails, {Key? key}) : super(key: key);
  final ChannelDetailsItem? channelDetails;

  @override
  State<TabBarVideosView> createState() => _TabBarVideosViewState();
}

class _TabBarVideosViewState extends State<TabBarVideosView>
    with AutomaticKeepAliveClientMixin<TabBarVideosView> {
  final logic = Get.find<ChannelProfileLogic>(tag: "1");

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      return logic.getRecentlyVideosSelected
          ? _NewestVideos(widget.channelDetails)
          : _PopularVideos(widget.channelDetails);
    });
  }

  @override
  bool get wantKeepAlive => true;
}

class _PopularVideos extends StatelessWidget {
  const _PopularVideos(this.channelDetails);

  final ChannelDetailsItem? channelDetails;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelVideosCubit, ChannelVideosState>(
      bloc: ChannelVideosCubit.get(context)
        ..getPopularChannelVideos(channelDetails?.id ?? ""),
      builder: (context, state) {
        if (state is PopularVideosLoaded) {
          return _VideosList(state.videoDetails);
        } else if (state is Error) {
          return Center(
            child: Text(
                NetworkExceptions.getErrorMessage(
                    state.networkExceptions.networkExceptions),
                style: getNormalStyle(
                    color: ColorManager(context).black, fontSize: 15)),
          );
        } else {
          return const ThineCircularProgress();
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
      builder: (context, state) {
        if (state is ChannelVideosLoaded) {
          return _VideosList(state.videoDetails);
        } else if (state is Error) {
          return Center(
            child: Text(
                NetworkExceptions.getErrorMessage(
                    state.networkExceptions.networkExceptions),
                style: getNormalStyle(
                    color: ColorManager(context).black, fontSize: 15)),
          );
        } else {
          return const ThineCircularProgress();
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
    return ListView.builder(
        itemBuilder: (context, index) => Padding(
              padding: REdgeInsetsDirectional.only(start: 15, top: 15),
              child: index == 0
                  ? const _FiltersButtons()
                  : VideoHorizontalDescriptionsList(
                      videoDetails.videoDetailsItem![index]),
            ),
        itemCount: videoDetails.videoDetailsItem?.length ?? 0);
  }
}

class _FiltersButtons extends StatefulWidget {
  const _FiltersButtons();

  @override
  State<_FiltersButtons> createState() => _FiltersButtonsState();
}

class _FiltersButtonsState extends State<_FiltersButtons> {
  final logic = Get.find<ChannelProfileLogic>(tag: "1");

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          children: [
            GestureDetector(
                onTap: () => logic.isRecentlyVideosSelected = true,
                child: _RoundedFilteredButton(
                    text: "Recently uploaded",
                    isSelected: logic.getRecentlyVideosSelected)),
            const RSizedBox(width: 10),
            GestureDetector(
                onTap: () => logic.isRecentlyVideosSelected = false,
                child: _RoundedFilteredButton(
                    text: "Popular",
                    isSelected: !logic.getRecentlyVideosSelected)),
          ],
        ));
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
