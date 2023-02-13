import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube/core/utility/injector.dart';
import 'package:youtube/presentation/cubit/channel_details/channel_details_cubit.dart';
import 'package:youtube/presentation/cubit/single_video_details/single_video_cubit.dart';
import 'package:youtube/presentation/cubit/videos_details/videos_details_cubit.dart';

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
    ], child: materialApp);
  }
}
