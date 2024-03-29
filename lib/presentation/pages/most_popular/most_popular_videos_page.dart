import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/assets_manager.dart';

import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/presentation/common_widgets/arrow_back.dart';
import 'package:youtube/presentation/common_widgets/error_message_widget.dart';
import 'package:youtube/presentation/common_widgets/search_icon.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';
import 'package:youtube/presentation/common_widgets/thumbnail_of_video.dart';
import 'package:youtube/presentation/common_widgets/videos_list_loading.dart';
import 'package:youtube/presentation/cubit/videos/popular_videos/popular_videos_cubit.dart';

class MostPopularVideosPage extends StatefulWidget {
  const MostPopularVideosPage({Key? key}) : super(key: key);

  @override
  State<MostPopularVideosPage> createState() => _MostPopularVideosPageState();
}

class _MostPopularVideosPageState extends State<MostPopularVideosPage> {
  @override
  void didChangeDependencies() {
    PopularVideosCubit.get(context).clearAllPopularVideos(videoCategoryId: "");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: const ArrowBack(),
                titleSpacing: 0,
                actionsIconTheme: const IconThemeData(size: 20),
                backgroundColor: ColorManager(context).white,
                surfaceTintColor: ColorManager(context).white,
                title: Text(
                  "Trending",
                  style: getMediumStyle(
                      color: ColorManager(context).black, fontSize: 20),
                ),
                floating: true,
                pinned: true,
                snap: true,
                actions: const [
                  Row(
                    children: [
                      RSizedBox(width: 20),
                      SearchIcon(),
                      RSizedBox(width: 20),
                      SvgIcon(IconsAssets.menuPointsVerticalIcon, size: 15),
                      RSizedBox(width: 20),
                    ],
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50.h),
                  child: const _TabBarIcons(),
                ),
              ),
            ];
          },
          body: const _TapBarView(),
        ),
      ),
    );
  }
}

class _TapBarView extends StatelessWidget {
  const _TapBarView();

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [
        _NowPopularVideos(),
        _MusicPopularVideos(),
        _GamingPopularVideos(),
        _MoviesPopularVideos(),
      ],
    );
  }
}

class _NowPopularVideos extends StatefulWidget {
  const _NowPopularVideos();

  @override
  State<_NowPopularVideos> createState() => _NowPopularVideosState();
}

class _NowPopularVideosState extends State<_NowPopularVideos> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularVideosCubit, PopularVideosState>(
      bloc: PopularVideosCubit.get(context)..getMostPopularVideos(),
      builder: (context, state) {
        if (state is MostPopularVideosLoaded) {
          return _BuildVideosList(state.mostPopularVideos);
        } else if (state is Error) {
          return ErrorMessageWidget(state.networkExceptions);
        } else {
          return const VideosListLoading();
        }
      },
    );
  }
}

class _MusicPopularVideos extends StatefulWidget {
  const _MusicPopularVideos();

  @override
  State<_MusicPopularVideos> createState() => _MusicPopularVideosState();
}

class _MusicPopularVideosState extends State<_MusicPopularVideos> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularVideosCubit, PopularVideosState>(
      bloc: PopularVideosCubit.get(context)..getMostPopularMusicVideos(),
      builder: (context, state) {
        if (state is MostPopularMusicVideosLoaded) {
          return _BuildVideosList(state.mostPopularVideos);
        } else if (state is Error) {
          return ErrorMessageWidget(state.networkExceptions);
        } else {
          return const VideosListLoading();
        }
      },
    );
  }
}

class _GamingPopularVideos extends StatefulWidget {
  const _GamingPopularVideos();

  @override
  State<_GamingPopularVideos> createState() => _GamingPopularVideosState();
}

class _GamingPopularVideosState extends State<_GamingPopularVideos> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularVideosCubit, PopularVideosState>(
      bloc: PopularVideosCubit.get(context)..getMostPopularGamingVideos(),
      builder: (context, state) {
        if (state is MostPopularGamingVideosLoaded) {
          return _BuildVideosList(state.mostPopularVideos);
        } else if (state is Error) {
          return ErrorMessageWidget(state.networkExceptions);
        } else {
          return const VideosListLoading();
        }
      },
    );
  }
}

class _MoviesPopularVideos extends StatefulWidget {
  const _MoviesPopularVideos();

  @override
  State<_MoviesPopularVideos> createState() => _MoviesPopularVideosState();
}

class _MoviesPopularVideosState extends State<_MoviesPopularVideos> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularVideosCubit, PopularVideosState>(
      bloc: PopularVideosCubit.get(context)..getMostPopularMoviesVideos(),
      builder: (context, state) {
        if (state is MostPopularMoviesVideosLoaded) {
          return _BuildVideosList(state.mostPopularVideos);
        } else if (state is Error) {
          return ErrorMessageWidget(state.networkExceptions);
        } else {
          return const VideosListLoading();
        }
      },
    );
  }
}

class _BuildVideosList extends StatelessWidget {
  const _BuildVideosList(this.videos);
  final VideosDetails videos;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) =>
            ThumbnailOfVideo(videos.videoDetailsItem?[index]),
        itemCount: videos.videoDetailsItem?.length ?? 0);
  }
}

class _TabBarIcons extends StatelessWidget {
  const _TabBarIcons();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: ColorManager(context).grey2))),
      child: TabBar(
        unselectedLabelColor: ColorManager(context).grey7,
        labelColor: Theme.of(context).focusColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator:
            const BoxDecoration(border: Border(bottom: BorderSide(width: 2))),
        labelStyle:
            getMediumStyle(fontSize: 14, color: ColorManager(context).black),
        tabs: const [
          Tab(child: Text("NOW")),
          Tab(child: Text("MUSIC")),
          Tab(child: Text("GAMING")),
          Tab(child: Text("MOVIES")),
        ],
      ),
    );
  }
}
