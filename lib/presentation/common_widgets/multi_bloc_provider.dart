part of '../my_app.dart';

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
        create: (context) =>
            injector<ChannelDetailsCubit>()..getMySubscriptionsChannels(),
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
