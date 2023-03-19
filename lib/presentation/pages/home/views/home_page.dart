import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/core/functions/handling_errors/network_exceptions.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/presentation/common_widgets/sliver_app_bar.dart';
import 'package:youtube/presentation/common_widgets/thumbnail_of_video.dart';
import 'package:youtube/presentation/common_widgets/videos_list_loading.dart';
import 'package:youtube/presentation/cubit/videos/videos_details_cubit.dart';
import 'package:youtube/presentation/pages/most_popular/most_popular_videos_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification) {
              double pixels = scrollNotification.metrics.pixels;
              double itemHeight = 185.h;
              int inView = (pixels / itemHeight).floor();
              if (inView != index) setState(() => index = inView);
            }
            return true;
          },
          child: CustomScrollView(
            slivers: [
              MainSliverAppBar(
                preferredSizeWidget: PreferredSize(
                  preferredSize: Size.fromHeight(50.h),
                  child: const _SuggestionsList(),
                ),
              ),
              _VideosList(index),
            ],
          ),
        ),
      ),
    );
  }
}

class _VideosList extends StatefulWidget {
  final int index;
  const _VideosList(this.index);

  @override
  State<_VideosList> createState() => _VideosListState();
}

class _VideosListState extends State<_VideosList>
    with AutomaticKeepAliveClientMixin<_VideosList> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<VideosDetailsCubit, VideosDetailsState>(
      bloc: VideosDetailsCubit.get(context)..getAllVideos(),
      buildWhen: (previous, current) =>
          previous != current && current is AllVideosLoaded,
      builder: (context, state) {
        if (state is AllVideosLoaded) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: state.allVideosLoaded.videoDetailsItem?.length,
              (context, index) {
                return ThumbnailOfVideo(
                  state.allVideosLoaded.videoDetailsItem?[index],
                  playVideo: index == widget.index,
                );
              },
            ),
          );
        } else if (state is VideoError) {
          return SliverFillRemaining(
            child: Center(
              child: Text(
                  NetworkExceptions.getErrorMessage(
                      state.networkExceptions.networkExceptions),
                  style: getNormalStyle(
                      color: ColorManager(context).black, fontSize: 15)),
            ),
          );
        } else {
          return const SliverFillRemaining(child: VideosListLoading());
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SuggestionsList extends StatelessWidget {
  const _SuggestionsList();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: ColorManager(context).white,
      height: 50.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: const [
          RSizedBox(width: 10),
          _PopularButton(),
          RSizedBox(width: 10),
          _VerticalDivider(),
          RSizedBox(width: 10),
          _SuggestionsButtons()
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 12),
      child: Container(
          height: 20.h, width: .5, color: ColorManager(context).grey3),
    );
  }
}

class _SuggestionsButtons extends StatefulWidget {
  const _SuggestionsButtons();

  @override
  State<_SuggestionsButtons> createState() => _SuggestionsButtonsState();
}

class _SuggestionsButtonsState extends State<_SuggestionsButtons> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () => setState(() => selectedIndex = 0),
            child: _RoundedButton(text: "All", isSelected: selectedIndex == 0)),
        const RSizedBox(width: 10),
        GestureDetector(
            onTap: () => setState(() => selectedIndex = 1),
            child:
                _RoundedButton(text: "Comedy", isSelected: selectedIndex == 1)),
        const RSizedBox(width: 10),
        GestureDetector(
            onTap: () => setState(() => selectedIndex = 2),
            child: _RoundedButton(
                text: "Recently uploaded", isSelected: selectedIndex == 2)),
      ],
    );
  }
}

class _RoundedButton extends StatelessWidget {
  const _RoundedButton({
    Key? key,
    required this.isSelected,
    required this.text,
  }) : super(key: key);
  final bool isSelected;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(vertical: 8, horizontal: 13),
      decoration: BoxDecoration(
          color: isSelected
              ? ColorManager(context).black
              : ColorManager(context).grey1,
          borderRadius: BorderRadius.circular(20.r)),
      child: Text(
        text,
        style: getNormalStyle(
            color: isSelected
                ? ColorManager(context).white
                : ColorManager(context).black,
            fontSize: 13),
      ),
    );
  }
}

class _PopularButton extends StatelessWidget {
  const _PopularButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Go(context).to(const MostPopularVideosPage());
      },
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          padding: REdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: ColorManager(context).grey1,
              borderRadius: BorderRadius.circular(3.r)),
          child: Icon(Icons.navigation_outlined,
              size: 20, color: ColorManager(context).black),
        ),
      ),
    );
  }
}
