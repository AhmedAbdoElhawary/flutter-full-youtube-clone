import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/channel_details/channel_sub_details/channel_sub_details_extension.dart';
import 'package:youtube/presentation/common_widgets/app_bars/custom_app_bar.dart';
import 'package:youtube/presentation/common_widgets/circular_profile_image.dart';
import 'package:youtube/presentation/common_widgets/custom_circle_progress.dart';
import 'package:youtube/presentation/common_widgets/custom_network_display.dart';
import 'package:youtube/presentation/common_widgets/error_message_widget.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';
import 'package:youtube/presentation/cubit/channel/channel_details_cubit.dart';
import 'package:youtube/presentation/pages/channel_profile/channel_profile_logic.dart';
import '../../../core/resources/color_manager.dart';
import '../../common_widgets/subscribe_button.dart';
import 'profile_page.dart';

class UserChannelPageParameters {
  final ChannelDetailsItem? channelDetailsItem;
  final String channelId;

  UserChannelPageParameters({this.channelDetailsItem, required this.channelId});
}

class UserChannelPage extends StatelessWidget {
  const UserChannelPage(this.parameters, {Key? key}) : super(key: key);
  final UserChannelPageParameters parameters;

  @override
  Widget build(BuildContext context) {
    Get.put(ChannelProfileLogic(), tag: "1");
    if (parameters.channelDetailsItem == null) {
      return BlocBuilder<ChannelDetailsCubit, ChannelDetailsState>(
        bloc: ChannelDetailsCubit.get(context)
          ..getChannelSubDetails(parameters.channelId),
        builder: (context, state) {
          if (state is ChannelSubDetailsLoaded) {
            return _BuildScaffold(state.channelSubDetails.items?[0]);
          } else if (state is SubscriptionError) {
            return ErrorMessageWidget(state.networkExceptions);
          } else {
            return const ThineCircularProgress();
          }
        },
      );
    } else {
      return _BuildScaffold(parameters.channelDetailsItem);
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
        appBar: CustomAppBar(context).normalAppBar(
          channelDetails?.getName() ?? "",
          onTabBack: () {
            final logic = Get.find<ChannelProfileLogic>(tag: "1");
            logic.clearChannelCachedDetails(channelDetails?.id ?? "");
            Go(context).back();
          },
        ),
        body: ProfilePage(
          isThatMyPersonalId: true,
          widgetsAboveBio: _ButtonsAboveBio(channelDetails!),
          channelDetails: channelDetails,
        ),
      );
    }
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
          setState(() => favorite = !favorite);
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
        CustomNetworkDisplay(imageUrl: channelItem.getChannelCoverUrl()),
        const RSizedBox(height: 10),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              CircularProfileImage(
                  enableTapping: false,
                  radius: 30,
                  imageUrl: channelItem.getProfileImageUrl()),
              const RSizedBox(height: 15),
              Text(
                channelItem.getName(),
                style: getBoldStyle(
                    color: ColorManager(context).black, fontSize: 22),
              ),
              const RSizedBox(height: 5),
              Text(
                "${channelItem.getCustomUserName()} . $subscribersCount . $viewsCount",
                style: getNormalStyle(
                    color: ColorManager(context).black, fontSize: 12),
              ),
              const RSizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        channelItem.getBio(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: getNormalStyle(
                            color: ColorManager(context).grey, fontSize: 12),
                      ),
                    ),
                  ),
                  const RSizedBox(width: 5),
                  SvgIcon(IconsAssets.rightArrowIcon,
                      color: ColorManager(context).grey8, size: 20)
                ],
              ),
              const RSizedBox(height: 10),
              SubscribeButton(fontSize: 15,channelItem: channelItem),
            ],
          ),
        ),
      ],
    );
  }
}
