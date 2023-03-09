import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/presentation/common_widgets/error_message_widget.dart';
import 'package:youtube/presentation/common_widgets/horizontal_videos_loading.dart';
import 'package:youtube/presentation/cubit/channel/channel_videos/channel_videos_cubit.dart';
import 'videos_horizontal_descriptions_list.dart';

class TabBarHomeView extends StatefulWidget {
  const TabBarHomeView(this.channelDetails, {Key? key}) : super(key: key);
  final ChannelDetailsItem? channelDetails;

  @override
  State<TabBarHomeView> createState() => _TabBarHomeViewState();
}

class _TabBarHomeViewState extends State<TabBarHomeView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: REdgeInsetsDirectional.only(start: 15, top: 15),
            child: const _PopularVideosText(),
          ),
        ),
        _BuildVideosList(channelDetails: widget.channelDetails),
      ],
    );
  }
}

class _BuildVideosList extends StatelessWidget {
  const _BuildVideosList({required this.channelDetails});

  final ChannelDetailsItem? channelDetails;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelVideosCubit, ChannelVideosState>(
      bloc: ChannelVideosCubit.get(context)
        ..getChannelVideos(channelDetails?.id ?? ""),
      builder: (context, state) {
        if (state is ChannelVideosLoaded) {
          return SliverToBoxAdapter(
            child: ListView.builder(
                itemBuilder: (context, index) => Padding(
                      padding: REdgeInsetsDirectional.only(start: 15, top: 15),
                      child: VideoHorizontalDescriptionsList(
                          state.videoDetails.videoDetailsItem![index]),
                    ),
                itemCount: state.videoDetails.videoDetailsItem?.length ?? 0),
          );
        } else if (state is Error) {
          return SliverFillRemaining(
              child: ErrorMessageWidget(state.networkExceptions));
        } else {
          return const SliverHorizontalVideosShimmerLoading();
        }
      },
    );
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
