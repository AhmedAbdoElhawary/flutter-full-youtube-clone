import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/functions/network_exceptions.dart';

import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/presentation/common_widgets/custom_circle_progress.dart';
import 'package:youtube/presentation/common_widgets/thumbnail_of_video.dart';
import 'package:youtube/presentation/cubit/videos/popular_videos/popular_videos_cubit.dart';

class MostPopularVideosPage extends StatelessWidget {
  const MostPopularVideosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: const Icon(Icons.yard_outlined, size: 40),
                actionsIconTheme: const IconThemeData(size: 20),
                backgroundColor: ColorManager(context).white,
                surfaceTintColor: ColorManager(context).white,
                title: const Text("Application"),
                floating: true,
                pinned: true,
                snap: true,
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

class _NowPopularVideosState extends State<_NowPopularVideos>
    with AutomaticKeepAliveClientMixin<_NowPopularVideos> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<PopularVideosCubit, PopularVideosState>(
      bloc: PopularVideosCubit.get(context)..getMostPopularVideos(),
      buildWhen: (previous, current) {
        return current.maybeWhen(
            mostPopularVideosLoaded: (_) => true,
            loading: () => true,
            error: (_) => true,
            orElse: () => false);
      },
      builder: (context, state) {
        return state.maybeWhen(
          mostPopularVideosLoaded: (mostPopularVideos) {
            return _BuildMoviesList(mostPopularVideos);
          },
          error: (e) {
            return Center(
              child: Text(
                  NetworkExceptions.getErrorMessage(e.networkExceptions),
                  style: getNormalStyle(
                      color: ColorManager(context).black, fontSize: 15)),
            );
          },
          loading: () {
            return const ThineCircularProgress();
          },
          orElse: () => const SizedBox(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _MusicPopularVideos extends StatefulWidget {
  const _MusicPopularVideos();

  @override
  State<_MusicPopularVideos> createState() => _MusicPopularVideosState();
}

class _MusicPopularVideosState extends State<_MusicPopularVideos>
    with AutomaticKeepAliveClientMixin<_MusicPopularVideos> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<PopularVideosCubit, PopularVideosState>(
      bloc: PopularVideosCubit.get(context)..getMostPopularMusicVideos(),
      buildWhen: (previous, current) {
        return current.maybeWhen(
            mostPopularMusicVideosLoaded: (mostPopularVideos) => true,
            loading: () => true,
            error: (error) => true,
            orElse: () => false);
      },
      builder: (context, state) {
        return state.maybeWhen(
          mostPopularMusicVideosLoaded: (mostPopularVideos) {
            return _BuildMoviesList(mostPopularVideos);
          },
          error: (e) {
            return Center(
              child: Text(
                  NetworkExceptions.getErrorMessage(e.networkExceptions),
                  style: getNormalStyle(
                      color: ColorManager(context).black, fontSize: 15)),
            );
          },
          loading: () {
            return const ThineCircularProgress();
          },
          orElse: () => const SizedBox(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _GamingPopularVideos extends StatefulWidget {
  const _GamingPopularVideos();

  @override
  State<_GamingPopularVideos> createState() => _GamingPopularVideosState();
}

class _GamingPopularVideosState extends State<_GamingPopularVideos>
    with AutomaticKeepAliveClientMixin<_GamingPopularVideos> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<PopularVideosCubit, PopularVideosState>(
      bloc: PopularVideosCubit.get(context)..getMostPopularGamingVideos(),
      buildWhen: (previous, current) {
        return current.maybeWhen(
            mostPopularGamingVideosLoaded: (_) => true,
            loading: () => true,
            error: (_) => true,
            orElse: () => false);
      },
      builder: (context, state) {
        return state.maybeWhen(
          mostPopularGamingVideosLoaded: (mostPopularVideos) {
            return _BuildMoviesList(mostPopularVideos);
          },
          error: (e) {
            return Center(
              child: Text(
                  NetworkExceptions.getErrorMessage(e.networkExceptions),
                  style: getNormalStyle(
                      color: ColorManager(context).black, fontSize: 15)),
            );
          },
          loading: () {
            return const ThineCircularProgress();
          },
          orElse: () => const SizedBox(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _MoviesPopularVideos extends StatefulWidget {
  const _MoviesPopularVideos();

  @override
  State<_MoviesPopularVideos> createState() => _MoviesPopularVideosState();
}

class _MoviesPopularVideosState extends State<_MoviesPopularVideos>
    with AutomaticKeepAliveClientMixin<_MoviesPopularVideos> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<PopularVideosCubit, PopularVideosState>(
      bloc: PopularVideosCubit.get(context)..getMostPopularMoviesVideos(),
      buildWhen: (previous, current) {
        return current.maybeWhen(
            mostPopularMoviesVideosLoaded: (_) => true,
            loading: () => true,
            error: (_) => true,
            orElse: () => false);
      },
      builder: (context, state) {
        return state.maybeWhen(
          mostPopularMoviesVideosLoaded: (mostPopularVideos) {
            return _BuildMoviesList(mostPopularVideos);
          },
          error: (e) {
            return Center(
              child: Text(
                  NetworkExceptions.getErrorMessage(e.networkExceptions),
                  style: getNormalStyle(
                      color: ColorManager(context).black, fontSize: 15)),
            );
          },
          loading: () {
            return const ThineCircularProgress();
          },
          orElse: () => const SizedBox(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _BuildMoviesList extends StatelessWidget {
  const _BuildMoviesList(this.videos);
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