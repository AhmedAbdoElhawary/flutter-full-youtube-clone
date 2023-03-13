import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/data/models/channel_details/channel_sub_details/channel_sub_details_extension.dart';
import 'package:youtube/presentation/common_widgets/search_icon.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';
import 'package:youtube/presentation/cubit/channel/channel_details_cubit.dart';
import 'package:youtube/presentation/pages/settings/settings_page.dart';

class MainSliverAppBar extends StatelessWidget {
  const MainSliverAppBar({required this.preferredSizeWidget, Key? key})
      : super(key: key);
  final PreferredSizeWidget preferredSizeWidget;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leading: const SizedBox(),
      leadingWidth: 0,
      titleSpacing: 0,
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: ColorManager(context).white,
      surfaceTintColor: ColorManager(context).white,
      actions: [
        Expanded(
          child: Row(
            children: const [
              RSizedBox(width: 20),
              _YoutubeLogo(),
              Spacer(),
              SvgIcon(IconsAssets.broadcastIcon, size: 20),
              RSizedBox(width: 20),
              SvgIcon(IconsAssets.notificationIcon),
              RSizedBox(width: 20),
              SearchIcon(),
              RSizedBox(width: 20),
              _MyChannelIconButton(),
              RSizedBox(width: 20),
            ],
          ),
        ),
      ],
      bottom: preferredSizeWidget,
    );
  }
}

class _YoutubeLogo extends StatelessWidget {
  const _YoutubeLogo();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SvgIcon(IconsAssets.youtubeLogo, size: 20),
        Positioned(
            top: -5.5,
            child:
                SvgPicture.asset(IconsAssets.youtubeLogoSolo, height: 29.5.r))
      ],
    );
  }
}

class _MyChannelIconButton extends StatelessWidget {
  const _MyChannelIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Go(context).to(const SettingsPage());
      },
      child: BlocBuilder<ChannelDetailsCubit, ChannelDetailsState>(
        bloc: ChannelDetailsCubit.get(context)..getMyChannelInfo(),
        builder: (context, state) {
          if (state is MyChannelInfoLoaded) {
            String url = state.info.items?[0]?.getChannelCoverUrl() ?? "";
            return CircleAvatar(
              backgroundColor: ColorManager(context).grey1,
              radius: 13,
              backgroundImage:
                  url.isEmpty ? null : CachedNetworkImageProvider(url),
            );
          } else {
            return CircleAvatar(
                backgroundColor: ColorManager(context).grey1, radius: 13);
          }
        },
      ),
    );
  }
}
