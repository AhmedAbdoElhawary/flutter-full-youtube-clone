import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists_extension.dart';
import 'package:youtube/presentation/common_widgets/error_message_widget.dart';
import 'package:youtube/presentation/common_widgets/horizontal_videos_loading.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';
import 'package:youtube/presentation/cubit/channel/playlist/play_list_cubit.dart';
import 'package:youtube/presentation/common_widgets/thumbnail_image.dart';
import 'package:youtube/presentation/pages/playlist_details/playlist_details.dart';

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
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const _SortPlaylists(),
        _NewestVideos(widget.channelDetails),
      ],
    );
  }
}

class _NewestVideos extends StatelessWidget {
  const _NewestVideos(this.channelDetails);

  final ChannelDetailsItem? channelDetails;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayListCubit, PlayListState>(
      bloc: PlayListCubit.get(context)
        ..getChannelPlayLists(channelId: channelDetails?.id ?? ""),
      buildWhen: (previous, current) =>
          previous != current && current is ChannelPlayListLoaded,
      builder: (context, state) {
        if (state is ChannelPlayListLoaded) {
          return _PlaylistsList(state.playLists);
        } else if (state is PlaylistError) {
          return SliverFillRemaining(
              child: ErrorMessageWidget(state.networkExceptions));
        } else {
          return const SliverHorizontalVideosShimmerLoading(forTwoTexts: true);
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

class _SortPlaylists extends StatefulWidget {
  const _SortPlaylists({Key? key}) : super(key: key);

  @override
  State<_SortPlaylists> createState() => _SortPlaylistsState();
}

class _SortPlaylistsState extends State<_SortPlaylists> {
  int selectedValue = 0;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          PopupMenuButton<int>(
            elevation: 7,
            color: ColorManager(context).white,
            surfaceTintColor: ColorManager(context).white,
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            enableFeedback: true,
            initialValue: selectedValue,
            constraints: BoxConstraints(maxWidth: 190.w),
            onSelected: (int item) => onSelectedProfileMenu(item),
            itemBuilder: (context) => profileItems(context),
            child: Padding(
              padding: REdgeInsetsDirectional.only(start: 15, top: 15),
              child: Row(
                children: [
                  const Icon(Icons.menu_rounded, size: 18),
                  const RSizedBox(width: 5),
                  Text("Sort by",
                      style: getNormalStyle(
                          color: ColorManager(context).black, fontSize: 15)),
                  const RSizedBox(width: 5),
                  const Icon(Icons.keyboard_arrow_down_sharp, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  onSelectedProfileMenu(int item) {
    setState(() => selectedValue = item == 0 ? 0 : 1);
  }

  List<PopupMenuEntry<int>> profileItems(BuildContext context) => [
        PopupMenuItem<int>(
          height: 40.r,
          value: 0,
          child: Text(
            "Date added (newest)",
            style: getNormalStyle(
                color: Theme.of(context).focusColor, fontSize: 15),
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          height: 40.r,
          child: Text(
            "Last video added",
            style: getNormalStyle(
                color: Theme.of(context).focusColor, fontSize: 15),
          ),
        ),
      ];
}

class PlaylistHorizontalDescriptionsList extends StatelessWidget {
  const PlaylistHorizontalDescriptionsList(this.playListsItem, {super.key});
  final PlayListItem? playListsItem;
  @override
  Widget build(BuildContext context) {
    String? playlistTitle = playListsItem?.getPlaylistTitle();
    String? channelName = playListsItem?.getChannelName();
    return InkWell(
      enableFeedback: true,
      onTap: () {
        Go(context).to(PlaylistDetailsPage(playListsItem: playListsItem));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ThumbnailImage(
            playListsItem?.getPlaylistThumbnails(),
            height: 80,
            width: 160,
            childAboveImage: _PlaylistCountBanner(playListsItem),
          ),
          const RSizedBox(width: 15),
          Expanded(
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
                        color: BaseColorManager.grey, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
              ],
            ),
          ),
          Padding(
            padding: REdgeInsetsDirectional.only(start: 10, end: 15),
            child: const SvgIcon(IconsAssets.menuPointsVerticalIcon, size: 12),
          ),
        ],
      ),
    );
  }
}

class _PlaylistCountBanner extends StatelessWidget {
  const _PlaylistCountBanner(this.playListsItem);

  final PlayListItem? playListsItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      height: 15.h,
      color: BaseColorManager.black54,
      child: _PlayListCount(playListsItem: playListsItem),
    );
  }
}

class _PlayListCount extends StatelessWidget {
  const _PlayListCount({this.playListsItem});

  final PlayListItem? playListsItem;

  @override
  Widget build(BuildContext context) {
    int? playlistCount = playListsItem?.getPlaylistCount();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.playlist_play_outlined,
          color: BaseColorManager.white,
          size: 15,
        ),
        const RSizedBox(width: 2),
        if (playlistCount != null && playlistCount != 0)
          Text(
            "$playlistCount",
            style: getMediumStyle(color: BaseColorManager.white, fontSize: 12),
          )
      ],
    );
  }
}
