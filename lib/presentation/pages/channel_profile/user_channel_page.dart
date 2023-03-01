import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/channel_details/channel_sub_details/channel_sub_details_extension.dart';
import 'package:youtube/presentation/common_widgets/circular_profile_image.dart';
import 'package:youtube/presentation/common_widgets/custom_circle_progress.dart';
import 'package:youtube/presentation/common_widgets/custom_network_display.dart';
import 'package:youtube/presentation/cubit/channel/channel_details_cubit.dart';
import 'package:youtube/presentation/pages/channel_profile/channel_profile_logic.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../common_widgets/subscribe_button.dart';
import 'profile_page.dart';

class UserChannelPage extends StatelessWidget {
  const UserChannelPage(
      {Key? key, this.channelDetailsItem, required this.channelId})
      : super(key: key);
  final ChannelDetailsItem? channelDetailsItem;
  final String channelId;

  @override
  Widget build(BuildContext context) {
    Get.put(ChannelProfileLogic(), tag: "1");
    if (channelDetailsItem == null) {
      return BlocBuilder<ChannelDetailsCubit, ChannelDetailsState>(
        bloc: ChannelDetailsCubit.get(context)..getChannelSubDetails(channelId),
        builder: (context, state) {
          return state.maybeWhen(
              channelSubDetailsLoaded: (channelSubDetails) =>
                  _BuildScaffold(channelSubDetails.items?[0]),
              loading: () => const ThineCircularProgress(),
              error: (error) => Center(
                  child: Text(NetworkExceptions.getErrorMessage(
                      error.networkExceptions))),
              orElse: () =>
                  const Center(child: Text("There is something wrong")));
        },
      );
    } else {
      return _BuildScaffold(channelDetailsItem);
    }
  }
}

class _BuildScaffold extends StatelessWidget {
  const _BuildScaffold(this.channelDetails, {Key? key}) : super(key: key);
  final ChannelDetailsItem? channelDetails;

  @override
  Widget build(BuildContext context) {
    if (channelDetails == null) {
      return const Center(child: Text("There is something wrong"));
    } else {
      return Scaffold(
        appBar: appBar(context, channelDetails),
        body: ProfilePage(
          isThatMyPersonalId: true,
          widgetsAboveBio: _ButtonsAboveBio(channelDetails!),
          channelDetails: channelDetails,
        ),
      );
    }
  }

  AppBar appBar(BuildContext context, ChannelDetailsItem? channelDetails) {
    return AppBar(
      leadingWidth: 60.w,
      backgroundColor: ColorManager(context).white,
      title: Text(
        channelDetails?.getName() ?? "",
        style: getNormalStyle(color: ColorManager(context).black, fontSize: 20),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      actions: [
        const _FavoriteIconButton(),
        Padding(
            padding: REdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(IconsAssets.menuPointsVerticalIcon)),
      ],
    );
  }
}

class _FavoriteIconButton extends StatefulWidget {
  const _FavoriteIconButton({
    Key? key,
  }) : super(key: key);

  @override
  State<_FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<_FavoriteIconButton> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            favorite = !favorite;
          });
        },
        child: favorite
            ? const Icon(Icons.favorite_rounded, color: ColorManager.blackRed)
            : const Icon(Icons.favorite_border_rounded));
  }
}

class _ButtonsAboveBio extends StatelessWidget {
  const _ButtonsAboveBio(this.channelItem, {Key? key}) : super(key: key);
  final ChannelDetailsItem channelItem;

  @override
  Widget build(BuildContext context) {
    String? subscribers = channelItem.getSubscribersCount();
    String subscribersCount =
        subscribers == "" ? "" : "$subscribers subscribers";

    String? videos = channelItem.getVideosCount();
    String viewsCount = videos == "" ? "" : "$videos videos";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: 90.h,
          child:
              CustomNetworkDisplay(imageUrl: channelItem.getChannelCoverUrl()),
        ),
        const RSizedBox(height: 10),
        CircularProfileImage(
            enableTapping: false,
            radius: 30,
            imageUrl: channelItem.getProfileImageUrl()),
        const RSizedBox(height: 15),
        Text(
          channelItem.getName(),
          style: getBoldStyle(color: ColorManager(context).black, fontSize: 22),
        ),
        const RSizedBox(height: 10),
        const SubscribeButton(fontSize: 15),
        const RSizedBox(height: 5),
        Text(
          "${channelItem.getCustomUserName()} . $subscribersCount . $viewsCount",
          style:
              getNormalStyle(color: ColorManager(context).black, fontSize: 12),
        ),
        const RSizedBox(height: 5),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 15),
          child: GestureDetector(
            onTap: () {},
            child: Text(
              channelItem.getBio(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: getNormalStyle(
                  color: ColorManager(context).grey, fontSize: 12),
            ),
          ),
        )
      ],
    );
  }
}