import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/presentation/common_widgets/rounded_button.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';
import 'package:youtube/presentation/cubit/channel/channel_details_cubit.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/styles_manager.dart';

class SubscribeButton extends StatefulWidget {
  const SubscribeButton({required this.channelId, this.fontSize = 17, Key? key})
      : super(key: key);
  final double fontSize;
  final String channelId;
  @override
  State<SubscribeButton> createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<SubscribeButton> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelDetailsCubit, ChannelDetailsState>(
      // bloc: ChannelDetailsCubit.get(context)..subscribeToChannel(widget.channelId),
      builder: (context, state) {
        return RoundedButton(
            backgroundColor: isClicked
                ? ColorManager(context).grey1
                : ColorManager(context).black,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: isClicked
                  ? const _SubscribedWidgets()
                  : Text(
                      "Subscribe",
                      style: getMediumStyle(
                          color: ColorManager(context).white, fontSize: 15),
                    ),
            ),
            onTap: () {
              setState(() => isClicked = !isClicked);
            });
      },
    );
  }
}

class _SubscribedWidgets extends StatelessWidget {
  const _SubscribedWidgets();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SvgIcon(
          IconsAssets.notificationIcon,
          height: 20,
        ),
        const RSizedBox(width: 5),
        Text(
          "Subscribed",
          style:
              getMediumStyle(color: ColorManager(context).black, fontSize: 15),
        ),
        const RSizedBox(width: 5),
        const SvgIcon(IconsAssets.downArrowIcon, height: 20)
      ],
    );
  }
}
