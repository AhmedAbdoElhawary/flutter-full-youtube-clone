import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists_extension.dart';
import 'package:youtube/presentation/common_widgets/error_message_widget.dart';
import 'package:youtube/presentation/common_widgets/horizontal_videos_loading.dart';
import 'package:youtube/presentation/common_widgets/sliver_app_bar.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';
import 'package:youtube/presentation/cubit/channel/playlist/play_list_cubit.dart';
import 'package:youtube/presentation/pages/playlist_details/playlist_details.dart';
import '../../../core/resources/assets_manager.dart';
import '../../common_widgets/thumbnail_image.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const MainSliverAppBar(
              preferredSizeWidget: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: SizedBox(),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 6,
                (context, index) {
                  return Container(
                      decoration: index != 5 ? null : _customBorder(context),
                      child: _VideosDownloadsMoviesItems(index));
                },
              ),
            ),
            const SliverToBoxAdapter(child: _PlayListsFilteredItem()),
            const SliverToBoxAdapter(child: _NewPlaylistItem()),
            const SliverToBoxAdapter(child: _WatchLaterItem()),
            const _SavedPlayLists(),
          ],
        ),
      ),
    );
  }
}

class _CustomPaddingWidget extends StatelessWidget {
  final bool paddingTop;
  final Widget child;
  const _CustomPaddingWidget(
      {this.paddingTop = false, required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(
          left: 15, right: 15, bottom: 15, top: paddingTop ? 15 : 0),
      child: child,
    );
  }
}

BoxDecoration _customBorder(BuildContext context) {
  return BoxDecoration(
      border: Border(
          bottom: BorderSide(width: 1, color: ColorManager(context).grey2)));
}

class _VideosDownloadsMoviesItems extends StatelessWidget {
  const _VideosDownloadsMoviesItems(this.index);
  final int index;
  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const _HistoryViewAllListButton();
      case 1:
        return const _LastVideosSeen();
      case 2:
        return const _CustomDivider();
      case 3:
        return const _CustomPaddingWidget(child: _YourVideosItem());
      case 4:
        return const _CustomPaddingWidget(child: _DownloadsItem());
      default:
        return const _CustomPaddingWidget(child: _YourMoviesItem());
    }
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(bottom: 15),
      child: Divider(color: ColorManager(context).grey2, height: 1),
    );
  }
}

class _HistoryViewAllListButton extends StatelessWidget {
  const _HistoryViewAllListButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            const Icon(Icons.watch_later_outlined),
            const RSizedBox(width: 10),
            Text(
              "History",
              style: getBoldStyle(
                  color: ColorManager(context).black, fontSize: 16),
            ),
            const Spacer(),
            Text(
              "VIEW ALL",
              style: getMediumStyle(color: ColorManager.darkBlue, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

class _LastVideosSeen extends StatelessWidget {
  const _LastVideosSeen();

  @override
  Widget build(BuildContext context) {
    return RSizedBox(
      height: 135,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => _ItemBuilderWidget(index),
          separatorBuilder: (context, index) => const RSizedBox(width: 5),
          itemCount: 30),
    );
  }
}

class _ItemBuilderWidget extends StatelessWidget {
  const _ItemBuilderWidget(this.index);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.only(
          start: index == 0 ? 10 : 0, end: index == 29 ? 10 : 0),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: REdgeInsetsDirectional.only(bottom: 15, start: 5, end: 5),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ThumbnailImage(null,
                  height: 70, width: 140, childAboveImage: SizedBox()),
              RSizedBox(height: 8),
              _VideoNameWithIconOptions(),
              RSizedBox(height: 5),
              _ChannelName(),
            ],
          ),
        ),
      ),
    );
  }
}

class _VideoNameWithIconOptions extends StatelessWidget {
  const _VideoNameWithIconOptions();

  @override
  Widget build(BuildContext context) {
    return RSizedBox(
      width: 140,
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Flutter ColorFiltered Widget",
              style: getNormalStyle(
                  color: ColorManager(context).black, fontSize: 12),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const SvgIcon(IconsAssets.menuPointsVerticalIcon, size: 12),
        ],
      ),
    );
  }
}

class _ChannelName extends StatelessWidget {
  const _ChannelName();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Ahmed Abdo",
      style: getNormalStyle(color: ColorManager(context).grey7, fontSize: 12),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}

class _YourMoviesItem extends StatelessWidget {
  const _YourMoviesItem();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            Icons.video_settings,
            size: 25,
          ),
        ),
        const RSizedBox(width: 15),
        Text(
          "Your movies",
          style:
              getNormalStyle(color: ColorManager(context).black, fontSize: 16),
        ),
      ],
    );
  }
}

class _DownloadsItem extends StatelessWidget {
  const _DownloadsItem();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            Icons.download_rounded,
            size: 25,
          ),
        ),
        const RSizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Downloads",
                style: getNormalStyle(
                    color: ColorManager(context).black, fontSize: 16),
              ),
              Text(
                "137 videos",
                style: getNormalStyle(
                    color: ColorManager(context).grey7, fontSize: 14),
              ),
            ],
          ),
        ),
        const _CheckIcon()
      ],
    );
  }
}

class _YourVideosItem extends StatelessWidget {
  const _YourVideosItem();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            Icons.video_collection,
            size: 25,
          ),
        ),
        const RSizedBox(width: 15),
        Text(
          "Your videos",
          style:
              getNormalStyle(color: ColorManager(context).black, fontSize: 16),
        ),
      ],
    );
  }
}

class _PlayListsFilteredItem extends StatelessWidget {
  const _PlayListsFilteredItem();

  @override
  Widget build(BuildContext context) {
    return _CustomPaddingWidget(
      paddingTop: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Playlists",
            style: getMediumStyle(
                color: ColorManager(context).black, fontSize: 17),
          ),
          Text(
            "Recently added",
            style: getNormalStyle(
                color: ColorManager(context).black, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class _NewPlaylistItem extends StatelessWidget {
  const _NewPlaylistItem();

  @override
  Widget build(BuildContext context) {
    return _CustomPaddingWidget(
      child: Row(
        children: [
          const SizedBox(
            width: 40,
            height: 40,
            child: Icon(Icons.add, size: 25, color: ColorManager.darkBlue),
          ),
          const RSizedBox(width: 15),
          Text(
            "New playlist",
            style: getNormalStyle(color: ColorManager.darkBlue, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _WatchLaterItem extends StatelessWidget {
  const _WatchLaterItem();

  @override
  Widget build(BuildContext context) {
    return _CustomPaddingWidget(
      child: Row(
        children: [
          const RSizedBox(
            width: 40,
            height: 40,
            child: Icon(
              Icons.watch_later_outlined,
              size: 25,
            ),
          ),
          const RSizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Watch later",
                style: getNormalStyle(
                    color: ColorManager(context).black, fontSize: 16),
              ),
              Text(
                "1,052 unwatched videos",
                style: getNormalStyle(
                    color: ColorManager(context).grey7, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SavedPlayLists extends StatelessWidget {
  const _SavedPlayLists();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayListCubit, PlayListState>(
      bloc: PlayListCubit.get(context)..getMyPlayLists(),
      buildWhen: (previous, current) =>
          previous != current && current is MyPlayListLoaded,
      builder: (context, state) {
        if (state is MyPlayListLoaded) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: state.playLists.items?.length ?? 0,
              (context, index) {
                PlayListItem? item = state.playLists.items![index];
                return _PlaylistItem(item: item);
              },
            ),
          );
        } else if (state is PlaylistError) {
          return SliverFillRemaining(
              child: ErrorMessageWidget(state.networkExceptions));
        } else {
          return const SliverHorizontalVideosShimmerLoading(
            heightOfImage: 35,
            widthOfImage: 45,
            forTwoTexts: true,
            withoutTopPaddingInFirstIndex: true,
            borderRadius: 5,
          );
        }
      },
    );
  }
}

class _PlaylistItem extends StatelessWidget {
  const _PlaylistItem({required this.item});

  final PlayListItem? item;

  @override
  Widget build(BuildContext context) {
    bool isThatMe = item?.getChannelName() == "ahmed abdo";

    return InkWell(
      onTap: () {
        Go(context).to(PlaylistDetailsPage(playListsItem: item));
      },
      child: _CustomPaddingWidget(
        child: Row(
          children: [
            ThumbnailImage(item?.getPlaylistThumbnails(),
                width: 45.w,
                height: 35.h,
                borderRadius: 5,
                childAboveImage: const SizedBox()),
            const RSizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item?.getPlaylistTitle() ?? "",
                    style: getNormalStyle(
                        color: ColorManager(context).black, fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "${isThatMe ? "" : "${item?.getChannelName()} ."}${item?.getPlaylistCount()} videos",
                    style: getNormalStyle(
                        color: ColorManager(context).grey7, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            // const _CheckIcon(),
          ],
        ),
      ),
    );
  }
}

class _CheckIcon extends StatelessWidget {
  const _CheckIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(3),
      decoration: BoxDecoration(
          color: ColorManager(context).black, shape: BoxShape.circle),
      child: Icon(
        Icons.check,
        color: ColorManager(context).white,
        size: 15,
      ),
    );
  }
}
