import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists_extension.dart';
import 'package:youtube/presentation/common_widgets/app_bars/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/presentation/common_widgets/custom_network_display.dart';
import 'package:youtube/presentation/common_widgets/error_message_widget.dart';
import 'package:youtube/presentation/common_widgets/horizontal_videos_loading.dart';
import 'package:youtube/presentation/common_widgets/rounded_button.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';
import 'package:youtube/presentation/common_widgets/thumbnail_image.dart';
import 'package:youtube/presentation/cubit/channel/playlist/play_list_cubit.dart';
import 'package:youtube/presentation/pages/channel_profile/tab_bar_views/videos_horizontal_descriptions_list.dart';

class PlaylistDetailsPage extends StatelessWidget {
  const PlaylistDetailsPage({required this.playListsItem, Key? key})
      : super(key: key);
  final PlayListItem? playListsItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context).normalAppBar( ""),
      body: CustomScrollView(
        slivers: [
          _PlayListOverview(playListsItem: playListsItem),
          if (playListsItem?.id != null) _PlaylistVideos(playListsItem!.id!),
        ],
      ),
    );
  }
}

class _PlayListOverview extends StatelessWidget {
  const _PlayListOverview({required this.playListsItem});

  final PlayListItem? playListsItem;

  @override
  Widget build(BuildContext context) {
    String imageUrl = playListsItem?.getPlaylistCoverImageUrl() ?? "";
    return SliverToBoxAdapter(
      child: SizedBox(
        width: double.infinity,
        height: 325.h,
        child: CustomNetworkDisplay(
          imageUrl: imageUrl,
          height: 325,
          width: double.infinity,
        ).blurred(
          colorOpacity: 0,
          blur: 55,
          overlay: _WidgetsAboveBlurHash(playListsItem: playListsItem),
        ),
      ),
    );
  }
}

class _WidgetsAboveBlurHash extends StatelessWidget {
  const _WidgetsAboveBlurHash({required this.playListsItem});

  final PlayListItem? playListsItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(top: 15, right: 15, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ThumbnailImage(playListsItem?.getPlaylistThumbnails(),
              height: 150.h,
              width: double.infinity,
              childAboveImage: const SizedBox()),
          const RSizedBox(height: 15),
          Text(playListsItem?.getPlaylistTitle() ?? "",
              style:
                  getMediumStyle(color: BaseColorManager.white, fontSize: 22),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          const RSizedBox(height: 10),
          _InteractionsButtonsWithSubInfo(playListsItem: playListsItem),
          const RSizedBox(height: 10),
          Row(
            children: const [
              Expanded(child: _PlayAllButton()),
              RSizedBox(width: 15),
              Expanded(child: _ShuffleButton()),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlayAllButton extends StatelessWidget {
  const _PlayAllButton();

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
        backgroundColor: BaseColorManager.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SvgIcon(
              IconsAssets.playIcon,
              color: BaseColorManager.black,
              size: 20,
            ),
            const RSizedBox(width: 5),
            Text(
              "Play all",
              style:
                  getMediumStyle(color: BaseColorManager.black, fontSize: 15),
            )
          ],
        ),
        onTap: () {});
  }
}

class _ShuffleButton extends StatelessWidget {
  const _ShuffleButton();

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
        backgroundColor: BaseColorManager.transparentGrey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SvgIcon(
              IconsAssets.shuffleIcon,
              color: BaseColorManager.white,
              size: 20,
            ),
            const RSizedBox(width: 5),
            Text(
              "Shuffle",
              style:
                  getMediumStyle(color: BaseColorManager.white, fontSize: 15),
            )
          ],
        ),
        onTap: () {});
  }
}

class _InteractionsButtonsWithSubInfo extends StatelessWidget {
  const _InteractionsButtonsWithSubInfo({required this.playListsItem});

  final PlayListItem? playListsItem;

  @override
  Widget build(BuildContext context) {
    String? privacy = playListsItem?.getPlayListStatus();
    bool isPrivacyPrivate = privacy == "private";
    bool isThatMe = playListsItem?.getChannelName() == "ahmed abdo";
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(playListsItem?.getChannelName() ?? "",
                  style: getMediumStyle(
                      color: BaseColorManager.white, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              const RSizedBox(height: 5),
              Row(
                children: [
                  Text("${playListsItem?.getPlaylistCount() ?? 0} videos",
                      style: getMediumStyle(
                          color: BaseColorManager.grey1, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const RSizedBox(width: 5),
                  if (isPrivacyPrivate) ...[
                    const SvgIcon(
                      IconsAssets.lockIcon,
                      size: 15,
                      color: BaseColorManager.grey1,
                    ),
                    Text("Private",
                        style: getMediumStyle(
                            color: BaseColorManager.grey1,
                            fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ],
              ),
            ],
          ),
        ),
        if (isThatMe) ...[
          _RoundedIconButton(
              const Icon(
                Icons.mode_edit_outlined,
                color: BaseColorManager.white,
                size: 20,
              ),
              onTap: () {}),
          const RSizedBox(width: 5),
          _RoundedIconButton(
              const Icon(
                Icons.download,
                color: BaseColorManager.white,
                size: 20,
              ),
              onTap: () {}),
        ] else ...[
          _RoundedIconButton(
              const Icon(
                Icons.library_add_outlined,
                color: BaseColorManager.white,
                size: 20,
              ),
              onTap: () {}),
          const RSizedBox(width: 5),
          _RoundedIconButton(
              const Icon(
                Icons.download,
                color: BaseColorManager.white,
                size: 20,
              ),
              onTap: () {}),
          const RSizedBox(width: 5),
          _RoundedIconButton(
              const SvgIcon(IconsAssets.shareIcon,
                  size: 20, color: BaseColorManager.white),
              onTap: () {}),
        ],
      ],
    );
  }
}

class _RoundedIconButton extends StatelessWidget {
  const _RoundedIconButton(this.icon, {this.onTap, Key? key}) : super(key: key);
  final Widget icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      enableFeedback: true,
      child: Container(
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: BaseColorManager.transparentGrey),
        padding: REdgeInsets.all(10),
        child: icon,
      ),
    );
  }
}

class _PlaylistVideos extends StatelessWidget {
  const _PlaylistVideos(this.playlistId);

  final String playlistId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayListCubit, PlayListState>(
      bloc: PlayListCubit.get(context)
        ..getPlayListItems(playlistId: playlistId),
      builder: (context, state) {
        if (state is PlayListItemsLoaded) {
          return _VideosList(state.playListVideos);
        } else if (state is PlaylistError) {
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
  final List<VideosDetails> videoDetails;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: videoDetails.length,
        (context, index) {
          VideoDetailsItem? videoItem =
              videoDetails[index].videoDetailsItem?[0];
          if (videoItem == null) return const SizedBox();
          return Padding(
            padding: REdgeInsetsDirectional.only(start: 15, top: 15),
            child: VideoHorizontalDescriptionsList(videoItem),
          );
        },
      ),
    );
  }
}
