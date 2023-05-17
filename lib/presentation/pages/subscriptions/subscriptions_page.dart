import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/core/helpers/toast_show.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/data/models/channel_details/my_subscriptions/my_subscription_item_extension.dart';
import 'package:youtube/data/models/channel_details/my_subscriptions/my_subscriptions_details.dart';
import 'package:youtube/presentation/common_widgets/circular_profile_image.dart';
import 'package:youtube/presentation/common_widgets/error_message_widget.dart';
import 'package:youtube/presentation/common_widgets/shimmer_loading.dart';
import 'package:youtube/presentation/common_widgets/sliver_app_bar.dart';
import 'package:youtube/presentation/common_widgets/thumbnail_of_video.dart';
import 'package:youtube/presentation/common_widgets/videos_list_loading.dart';
import 'package:youtube/presentation/cubit/channel/channel_details_cubit.dart';
import 'package:youtube/presentation/cubit/channel/channel_videos/channel_videos_cubit.dart';
import 'package:youtube/presentation/pages/channel_profile/user_channel_page.dart';

import '../../../core/resources/styles_manager.dart';
import 'logic/subscriptions_page_logic.dart';

class SubscriptionsPage extends StatefulWidget {
  const SubscriptionsPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionsPage> createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage>
    with AutomaticKeepAliveClientMixin<SubscriptionsPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            MainSliverAppBar(
                preferredSizeWidget: PreferredSize(
                    preferredSize: Size.fromHeight(130.h),
                    child: const SubscriptionsBottomAppBarWidget())),
            const _SubscribedVideos(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SubscribedVideos extends StatefulWidget {
  const _SubscribedVideos();

  @override
  State<_SubscribedVideos> createState() => _SubscribedVideosState();
}

class _SubscribedVideosState extends State<_SubscribedVideos>
    with AutomaticKeepAliveClientMixin<_SubscribedVideos> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<SubscriptionsPageLogic>(
        tag: "1",
        id: "update-subscribed-channels",
        builder: (controller) {
          return BlocBuilder<ChannelVideosCubit, ChannelVideosState>(
            bloc: ChannelVideosCubit.get(context)
              ..getVideosOfThoseChannels(controller.allSubscribedChannels),
            buildWhen: (previous, current) =>
                previous != current && current is VideosOfThoseChannelsLoaded,
            builder: (context, state) {
              if (state is VideosOfThoseChannelsLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.videoDetails.length,
                    (context, index) => Padding(
                      padding: REdgeInsets.only(bottom: 15),
                      child: ThumbnailOfVideo(state.videoDetails[index]),
                    ),
                  ),
                );
              } else if (state is ChannelError) {
                return SliverFillRemaining(
                    child: ErrorMessageWidget(state.networkExceptions));
              } else {
                return const SliverFillRemaining(child: VideosListLoading());
              }
            },
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}

class SubscriptionsBottomAppBarWidget extends StatelessWidget {
  const SubscriptionsBottomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: ColorManager(context).white,
      height: 130.h,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Row(
                children: [
                  const Flexible(child: _ChannelsCircularImage()),
                  RSizedBox(width: 55.w),
                ],
              ),
              const _AllChannelsTextButton(),
            ],
          ),
          const RSizedBox(height: 10),
          const _BottomChannelsWidget(),
        ],
      ),
    );
  }
}

class _BottomChannelsWidget extends StatelessWidget {
  const _BottomChannelsWidget();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionsPageLogic>(
      tag: "1",
      id: "update-selected-channel",
      builder: (controller) {
        switch (controller.selectedChannelIndex) {
          case null:
            return const Flexible(child: _FilteredOptions());
          default:
            return Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: InkWell(
                  onTap: () {
                    Go(context).to(
                      UserChannelPage(
                        UserChannelPageParameters(
                          channelId: controller.selectedChannelItemDetails
                                  ?.getChannelId() ??
                              "",
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "VIEW CHANNELS",
                    style: getMediumStyle(
                        color: ColorManager.darkBlue, fontSize: 13),
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}

class _AllChannelsTextButton extends StatelessWidget {
  const _AllChannelsTextButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55.w,
      height: 85.h,
      color: ColorManager(context).white,
      child: Center(
        child: Text(
          "ALL",
          style: getMediumStyle(color: ColorManager.darkBlue, fontSize: 15),
        ),
      ),
    );
  }
}

class _ChannelsCircularImage extends StatefulWidget {
  const _ChannelsCircularImage();

  @override
  State<_ChannelsCircularImage> createState() => _ChannelsCircularImageState();
}

class _ChannelsCircularImageState extends State<_ChannelsCircularImage>
    with AutomaticKeepAliveClientMixin<_ChannelsCircularImage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ChannelDetailsCubit, ChannelDetailsState>(
      bloc: ChannelDetailsCubit.get(context)..getMySubscriptionsChannels(),
      buildWhen: (previous, current) =>
          previous != current && current is MySubscriptionsChannelsLoaded,
      builder: (context, state) {
        if (state is MySubscriptionsChannelsLoaded) {
          return SizedBox(
            height: 85.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => _ChannelItem(
                  index, state.mySubscriptionsDetails.items![index]),
              separatorBuilder: (context, index) => const RSizedBox(width: 5),
              itemCount: state.mySubscriptionsDetails.items?.length ?? 0,
            ),
          );
        } else if (state is SubscriptionError) {
          ToastShow.reformatToast(context, state.networkExceptions.error);
          return const SizedBox();
        } else {
          return const _CircularLoading();
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _CircularLoading extends StatelessWidget {
  const _CircularLoading();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShimmerLoading(
          child: CircleAvatar(
              radius: 30, backgroundColor: ColorManager(context).grey),
        ),
        const RSizedBox(height: 5),
        ShimmerLoading(
            child: Container(
          width: 50.w,
          height: 5.h,
          color: ColorManager(context).grey,
        )),
      ],
    );
  }
}

class _ChannelItem extends StatelessWidget {
  const _ChannelItem(this.index, this.mySubscriptionsItem);
  final int index;
  final MySubscriptionsItem? mySubscriptionsItem;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionsPageLogic>(
      tag: "1",
      id: "update-selected-channel",
      builder: (controller) {
        int? selectedIndex = controller.selectedChannelIndex;

        return Padding(
          padding: REdgeInsetsDirectional.only(
              start: index == 0 ? 10 : 0, end: index == 49 ? 10 : 0),
          child: InkWell(
            onTap: () {
              controller.selectedChannelItemDetails = mySubscriptionsItem;
              controller.selectedChannelIndex = index;
            },
            child: Container(
              padding: REdgeInsetsDirectional.only(start: 5, end: 5),
              color: selectedIndex != null && selectedIndex == index
                  ? ColorManager.lightBlue
                  : null,
              width: 65.w,
              child: selectedIndex == index || selectedIndex == null
                  ? _ChannelImageName(mySubscriptionsItem)
                  : ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                          Color.fromARGB(48, 180, 180, 180),
                          BlendMode.modulate),
                      child: _ChannelImageName(mySubscriptionsItem)),
            ),
          ),
        );
      },
    );
  }
}

class _ChannelImageName extends StatelessWidget {
  const _ChannelImageName(this.mySubscriptionsItem);
  final MySubscriptionsItem? mySubscriptionsItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProfileImage(
          imageUrl: mySubscriptionsItem?.getChannelHighUrl() ?? "",
          radius: 30.r,
          enableTapping: false,
        ),
        const RSizedBox(height: 5),
        _ChannelName(mySubscriptionsItem)
      ],
    );
  }
}

class _ChannelName extends StatelessWidget {
  const _ChannelName(this.mySubscriptionsItem);
  final MySubscriptionsItem? mySubscriptionsItem;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        mySubscriptionsItem?.getChannelName() ?? "",
        style: getNormalStyle(color: ColorManager(context).grey7, fontSize: 12),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _FilteredOptions extends StatefulWidget {
  const _FilteredOptions();

  @override
  State<_FilteredOptions> createState() => _FilteredOptionsState();
}

class _FilteredOptionsState extends State<_FilteredOptions> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: REdgeInsetsDirectional.only(
              start: index == 0 ? 10 : 0, end: index == 5 ? 10 : 0),
          child: GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: _RoundedFilteredButton(
              isSelected: index == selectedIndex,
              text: "Today",
            ),
          ),
        ),
        separatorBuilder: (context, index) => const RSizedBox(width: 10),
        itemCount: 6,
      ),
    );
  }
}

class _RoundedFilteredButton extends StatelessWidget {
  const _RoundedFilteredButton({
    Key? key,
    required this.isSelected,
    required this.text,
  }) : super(key: key);
  final bool isSelected;

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: isSelected
              ? ColorManager(context).grey7
              : ColorManager(context).grey1,
          border: isSelected
              ? null
              : Border.all(color: ColorManager(context).grey4),
          borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        children: [
          Text(
            text,
            style: getNormalStyle(
                color: isSelected
                    ? ColorManager(context).white
                    : ColorManager(context).black,
                fontSize: 13),
          ),
        ],
      ),
    );
  }
}
