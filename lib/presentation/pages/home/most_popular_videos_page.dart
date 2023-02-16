import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/presentation/common_widgets/custom_circle_progress.dart';
import 'package:youtube/presentation/common_widgets/moved_thumbnail_video.dart';
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

class _NowPopularVideos extends StatelessWidget {
  const _NowPopularVideos();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularVideosCubit, PopularVideosState>(
      bloc: PopularVideosCubit.get(context)..getMostPopularVideos(),
      builder: (context, state) {
        return state.maybeWhen(
          mostPopularVideosLoaded: (mostPopularVideos) {
            return _BuildMoviesList(mostPopularVideos);
          },
          error: (e) {
            return Center(
              child: Text(e,
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
}

class _MusicPopularVideos extends StatelessWidget {
  const _MusicPopularVideos();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularVideosCubit, PopularVideosState>(
      bloc: PopularVideosCubit.get(context)..getMostPopularMusicVideos(),
      builder: (context, state) {
        return state.maybeWhen(
          mostPopularMusicVideosLoaded: (mostPopularVideos) {
            return _BuildMoviesList(mostPopularVideos);
          },
          error: (e) {
            return Center(
              child: Text(e,
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
}

class _GamingPopularVideos extends StatelessWidget {
  const _GamingPopularVideos();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularVideosCubit, PopularVideosState>(
      bloc: PopularVideosCubit.get(context)..getMostPopularGamingVideos(),
      builder: (context, state) {
        return state.maybeWhen(
          mostPopularGamingVideosLoaded: (mostPopularVideos) {
            return _BuildMoviesList(mostPopularVideos);
          },
          error: (e) {
            return Center(
              child: Text(e,
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
}

class _MoviesPopularVideos extends StatelessWidget {
  const _MoviesPopularVideos();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularVideosCubit, PopularVideosState>(
      bloc: PopularVideosCubit.get(context)..getMostPopularMoviesVideos(),
      builder: (context, state) {
        return state.maybeWhen(
          mostPopularMoviesVideosLoaded: (mostPopularVideos) {
            return _BuildMoviesList(mostPopularVideos);
          },
          error: (e) {
            return Center(
              child: Text(e,
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
}

class _BuildMoviesList extends StatelessWidget {
  const _BuildMoviesList(this.videos);
  final VideosDetails videos;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) =>
            MovedThumbnailVideo(videos.videoDetailsItem?[index]),
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
