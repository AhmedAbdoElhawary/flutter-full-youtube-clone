import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/widgets/sliver_app_bar.dart';
import 'package:youtube/presentation/common_widgets/custom_circle_progress.dart';
import 'package:youtube/presentation/common_widgets/moved_thumbnail_video.dart';
import 'package:youtube/presentation/cubit/videos_details/videos_details_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            MainSliverAppBar(
              preferredSizeWidget: PreferredSize(
                preferredSize: Size.fromHeight(50.h),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: ColorManager.green,
                  height: 50.h,
                ),
              ),
            ),
            BlocBuilder<VideosDetailsCubit, VideosDetailsState>(
              bloc: VideosDetailsCubit.get(context)..getMostPopularVideos(),
              builder: (context, state) {
                return state.maybeWhen(
                  mostPopularVideosLoaded: (mostPopularVideos) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: mostPopularVideos.videoDetailsItem?.length,
                        (context, index) => Padding(
                          padding: REdgeInsets.only(bottom: 15),
                          child: MovedThumbnailVideo(mostPopularVideos.videoDetailsItem?[index]),
                        ),
                      ),
                    );
                  },
                  loading: () {
                    return const SliverFillRemaining(
                        child: ThineCircularProgress());
                  },
                  orElse: () {
                    return const SliverFillRemaining(child: SizedBox());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
