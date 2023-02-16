import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube/core/utility/injector.dart';
import 'package:youtube/presentation/cubit/channel/channel_details_cubit.dart';
import 'package:youtube/presentation/cubit/channel/channel_videos/channel_videos_cubit.dart';
import 'package:youtube/presentation/cubit/channel/playlist/play_list_cubit.dart';
import 'package:youtube/presentation/cubit/search/search_cubit.dart';
import 'package:youtube/presentation/cubit/single_video/single_video_cubit.dart';
import 'package:youtube/presentation/cubit/videos/popular_videos/popular_videos_cubit.dart';
import 'package:youtube/presentation/cubit/videos/videos_details_cubit.dart';

class MultiBlocs extends StatelessWidget {
  final Widget materialApp;

  const MultiBlocs(this.materialApp, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<VideosDetailsCubit>(
        create: (context) => injector<VideosDetailsCubit>(),
      ),
      BlocProvider<ChannelDetailsCubit>(
        create: (context) => injector<ChannelDetailsCubit>(),
      ),
      BlocProvider<SingleVideoCubit>(
        create: (context) => injector<SingleVideoCubit>(),
      ),
      BlocProvider<ChannelVideosCubit>(
        create: (context) => injector<ChannelVideosCubit>(),
      ),
      BlocProvider<PlayListCubit>(
        create: (context) => injector<PlayListCubit>(),
      ),
      BlocProvider<SearchCubit>(
        create: (context) => injector<SearchCubit>(),
      ),
      BlocProvider<PopularVideosCubit>(
        create: (context) => injector<PopularVideosCubit>(),
      ),
    ], child: materialApp);
  }
}
