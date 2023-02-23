import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/presentation/common_widgets/sliver_app_bar.dart';
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 30,
                (context, index) {
                  return _CustomPaddingWidget(index, _PlaylistsItems(index));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomPaddingWidget extends StatelessWidget {
  final int index;
  final Widget child;
  const _CustomPaddingWidget(this.index, this.child, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(
          left: 15, right: 15, bottom: 15, top: index == 0 ? 15 : 0),
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
        return _CustomPaddingWidget(index, const _YourVideosItem());
      case 4:
        return _CustomPaddingWidget(index, const _DownloadsItem());

      default:
        return _CustomPaddingWidget(index, const _YourMoviesItem());
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ThumbnailImage(null, height: 70, width: 140),
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
          SvgPicture.asset(
            IconsAssets.menuPointsVerticalIcon,
            height: 12,
          )
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

class _PlaylistsItems extends StatelessWidget {
  const _PlaylistsItems(this.index, {Key? key}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const _PlayListsFilteredItem();
      case 1:
        return const _NewPlaylistItem();
      case 2:
        return const _WatchLaterItem();
      default:
        return const _SavedPlayLists();
    }
  }
}

class _PlayListsFilteredItem extends StatelessWidget {
  const _PlayListsFilteredItem();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Playlists",
          style: getBoldStyle(color: ColorManager(context).black, fontSize: 17),
        ),
        Text(
          "Recently added",
          style:
              getNormalStyle(color: ColorManager(context).black, fontSize: 15),
        ),
      ],
    );
  }
}

class _NewPlaylistItem extends StatelessWidget {
  const _NewPlaylistItem();

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class _WatchLaterItem extends StatelessWidget {
  const _WatchLaterItem();

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class _SavedPlayLists extends StatelessWidget {
  const _SavedPlayLists();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.h,
          height: 40.h,
          color: ColorManager(context).grey2,
        ),
        const RSizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SOLID Principles - بالعربي",
                style: getNormalStyle(
                    color: ColorManager(context).black, fontSize: 15),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                "Ahmed Abdo . 26 video",
                style: getNormalStyle(
                    color: ColorManager(context).grey7, fontSize: 13),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        const _CheckIcon(),
      ],
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
