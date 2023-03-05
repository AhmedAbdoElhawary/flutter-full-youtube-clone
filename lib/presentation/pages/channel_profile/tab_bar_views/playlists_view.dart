import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists_extension.dart';
import 'package:youtube/presentation/common_widgets/custom_circle_progress.dart';
import 'package:youtube/presentation/common_widgets/error_message_widget.dart';
import 'package:youtube/presentation/cubit/channel/playlist/play_list_cubit.dart';
import 'package:youtube/presentation/pages/channel_profile/channel_profile_logic.dart';
import 'package:youtube/presentation/pages/channel_profile/widgets/rounded_filtered_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube/presentation/common_widgets/thumbnail_image.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';

class TabBarPlaylistView extends StatefulWidget {
  const TabBarPlaylistView(this.channelDetails, {Key? key}) : super(key: key);
  final ChannelDetailsItem? channelDetails;

  @override
  State<TabBarPlaylistView> createState() => _TabBarPlaylistViewViewState();
}

class _TabBarPlaylistViewViewState extends State<TabBarPlaylistView> {
  final logic = Get.find<ChannelProfileLogic>(tag: "1");

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const _FiltersButtons(),
        _NewestVideos(widget.channelDetails),
        // Obx(() {
        //   return
        //       // logic.getRecentlyVideosSelected
        //       //   ?
        //
        //       // : _PopularVideos(widget.channelDetails)
        //       ;
        // })
      ],
    );
  }
}
//
// class _PopularVideos extends StatelessWidget {
//   const _PopularVideos(this.channelDetails);
//
//   final ChannelDetailsItem? channelDetails;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ChannelVideosCubit, ChannelVideosState>(
//       bloc: ChannelVideosCubit.get(context)
//         ..getPopularChannelVideos(channelDetails?.id ?? ""),
//       builder: (context, state) {
//         if (state is PopularVideosLoaded) {
//           return _PlaylistsList(state.videoDetails);
//         } else if (state is Error) {
//           return SliverFillRemaining(
//               child: ErrorMessageWidget(state.networkExceptions));
//         } else {
//           return const SliverFillRemaining(child: ThineCircularProgress());
//         }
//       },
//     );
//   }
// }

class _NewestVideos extends StatelessWidget {
  const _NewestVideos(this.channelDetails);

  final ChannelDetailsItem? channelDetails;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayListCubit, PlayListState>(
      bloc: PlayListCubit.get(context)
        ..getChannelPlayLists(channelId: channelDetails?.id ?? ""),
      builder: (context, state) {
        if (state is ChannelPlayListLoaded) {
          return _PlaylistsList(state.playLists);
        } else if (state is PlaylistError) {
          return SliverFillRemaining(
              child: ErrorMessageWidget(state.networkExceptions));
        } else {
          return const SliverFillRemaining(child: ThineCircularProgress());
        }
      },
    );
  }
}

class _PlaylistsList extends StatelessWidget {
  const _PlaylistsList(this.playLists);
  final PlayLists playLists;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: playLists.items?.length ?? 0,
        (context, index) => Padding(
          padding: REdgeInsetsDirectional.only(start: 15, top: 15),
          child: PlaylistHorizontalDescriptionsList(playLists.items![index]),
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
  final logic = Get.find<ChannelProfileLogic>(tag: "1");

  @override
  Widget build(BuildContext context) {
    return Obx(() => SliverToBoxAdapter(
          child: Padding(
            padding: REdgeInsetsDirectional.only(start: 15, top: 15),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () => logic.isRecentlyVideosSelected = true,
                    child: RoundedFilteredButton(
                        text: "Recently uploaded",
                        isSelected: logic.getRecentlyVideosSelected)),
                const RSizedBox(width: 10),
                GestureDetector(
                    onTap: () => logic.isRecentlyVideosSelected = false,
                    child: RoundedFilteredButton(
                        text: "Popular",
                        isSelected: !logic.getRecentlyVideosSelected)),
              ],
            ),
          ),
        ));
  }
}

class PlaylistHorizontalDescriptionsList extends StatelessWidget {
  const PlaylistHorizontalDescriptionsList(this.playListsItem, {super.key});
  final PlayListsItem? playListsItem;
  @override
  Widget build(BuildContext context) {
    int? playlistCount = playListsItem?.getPlaylistCount();
    String? playlistTitle = playListsItem?.getPlaylistTitle();
    String? channelName = playListsItem?.getChannelName();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThumbnailImage(
          playListsItem?.getPlaylistThumbnails(),
          height: 80,
          width: 160,
          childAboveImage: _PlaylistCountBanner(playlistCount: playlistCount),
        ),
        const RSizedBox(width: 15),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (playlistTitle != null)
                Text(
                  playlistTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: getNormalStyle(
                      color: ColorManager(context).black, fontSize: 14),
                ),
              const RSizedBox(height: 3),
              if (channelName != null)
                Text(
                  channelName,
                  style: getNormalStyle(
                      color: ColorManager(context).grey7, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
            ],
          ),
        ),
        Padding(
          padding: REdgeInsetsDirectional.only(start: 10, end: 15),
          child:
              SvgPicture.asset(IconsAssets.menuPointsVerticalIcon, height: 12),
        ),
      ],
    );
  }
}

class _PlaylistCountBanner extends StatelessWidget {
  const _PlaylistCountBanner({required this.playlistCount});

  final int? playlistCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      height: 15.h,
      color: BaseColorManager.black,
      child: Center(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.playlist_play_outlined,
            color: BaseColorManager.white,
            size: 12,
          ),
          const RSizedBox(width: 5),
          if (playlistCount != null && playlistCount != 0)
            Text(
              "$playlistCount",
              style:
                  getMediumStyle(color: BaseColorManager.white, fontSize: 12),
            )
        ],
      )),
    );
  }
}
