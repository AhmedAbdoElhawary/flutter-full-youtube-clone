import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/core/functions/reformat/views_reformat.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/presentation/common_widgets/circular_profile_image.dart';
import 'package:youtube/presentation/common_widgets/custom_circle_progress.dart';
import 'package:youtube/presentation/cubit/channel/channel_details_cubit.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../common_widgets/subscribe_button.dart';
import 'profile_page.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage(
      {Key? key, required this.channelDetailsItem, required this.channelId})
      : super(key: key);
  final ChannelDetailsItem? channelDetailsItem;
  final String channelId;

  @override
  Widget build(BuildContext context) {
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
  const _BuildScaffold(this.channelDetailsItem, {Key? key}) : super(key: key);
  final ChannelDetailsItem? channelDetailsItem;

  @override
  Widget build(BuildContext context) {
    if (channelDetailsItem == null) {
      return const Center(child: Text("There is something wrong"));
    } else {
      return Scaffold(
        appBar: appBar(context),
        body: ProfilePage(
          isThatMyPersonalId: true,
          widgetsAboveBio: _ButtonsAboveBio(channelDetailsItem!),
        ),
      );
    }
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leadingWidth: 60.w,
      backgroundColor: ColorManager(context).white,
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
  const _ButtonsAboveBio(this.channelDetailsItem, {Key? key}) : super(key: key);
  final ChannelDetailsItem channelDetailsItem;

  @override
  Widget build(BuildContext context) {
    ChannelSnippet? snippet = channelDetailsItem.snippet;
    String? subscribers = channelDetailsItem.statistics?.subscriberCount;
    String? views = channelDetailsItem.statistics?.viewCount;

    String subscribersCount =
        CountsReformat.basicCountFormat(subscribers ?? "");
    subscribersCount += " subscribers";
    String viewsCount = CountsReformat.basicCountFormat(views ?? "");
    viewsCount += " videos";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: double.infinity, height: 90.h, color: ColorManager.green),
        const RSizedBox(height: 10),
        const CircularProfileImage(enableTapping: false, radius: 30),
        const RSizedBox(height: 15),
        Text(
          snippet?.title ?? "",
          style: getBoldStyle(color: ColorManager(context).black, fontSize: 22),
        ),
        const RSizedBox(height: 10),
        const SubscribeButton(fontSize: 15),
        const RSizedBox(height: 5),
        Text(
          "${snippet?.customUrl ?? ""} . ${subscribers == null ? "" : subscribersCount} . ${views == null ? "" : viewsCount}",
          style:
              getNormalStyle(color: ColorManager(context).black, fontSize: 12),
        ),
        const RSizedBox(height: 5),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 15),
          child: GestureDetector(
            onTap: () {
              /// TODO: push to about page
            },
            child: Text(
              snippet?.description ?? "",
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
