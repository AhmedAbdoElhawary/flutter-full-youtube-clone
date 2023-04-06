import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/functions/handling_errors/network_exceptions.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/presentation/common_widgets/sliver_app_bar.dart';
import 'package:youtube/presentation/common_widgets/thumbnail_of_video.dart';
import 'package:youtube/presentation/common_widgets/videos_list_loading.dart';
import 'package:youtube/presentation/cubit/videos/popular_videos/popular_videos_cubit.dart';
import 'package:youtube/presentation/cubit/videos/videos_details_cubit.dart';
import 'package:youtube/presentation/custom_packages/in_view_notifier/in_view_notifier_custom.dart';
import 'package:youtube/presentation/custom_packages/in_view_notifier/in_view_notifier_widget.dart';
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
    savedContext ??= context;

    return Scaffold(
      body: SafeArea(
        child: InViewNotifierCustomScrollView(
          slivers: [
            MainSliverAppBar(
              preferredSizeWidget: PreferredSize(
                preferredSize: Size.fromHeight(50.h),
                child: const _SuggestionsList(),
              ),
            ),
            _VideosList(index),
          ],
          onRefreshData: () async {},
          physics: const BouncingScrollPhysics(),
          initialInViewIds: const ['0'],
          isInViewPortCondition:
              (double deltaTop, double deltaBottom, double vpHeight) {
            return deltaTop < (0.5 * vpHeight) &&
                deltaBottom > (0.5 * vpHeight);
          },
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
                return InViewNotifierWidget(
                  id: '$index',
                  builder: (_, bool isInView, __) {

                    return ThumbnailOfVideo(
                      state.allVideosLoaded.videoDetailsItem?[index],
                      playVideo: isInView,
                    );
                  },
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
        Navigator.of(context, rootNavigator: true)
            .push(MaterialPageRoute(
                builder: (context) => const MostPopularVideosPage(),
                maintainState: false))
            .then((_) {
          PopularVideosCubit.get(context)
              .clearAllPopularVideos(videoCategoryId: "");
        });
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
