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
  const SubscribeButton(
      {required this.channelId,
      this.fontSize = 15,
      this.makeItExpanded = true,
      Key? key})
      : super(key: key);
  final double fontSize;
  final String channelId;
  final bool makeItExpanded;

  @override
  State<SubscribeButton> createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<SubscribeButton> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelDetailsCubit, ChannelDetailsState>(
      builder: (context, state) {
        return RoundedButton(
            makeItExpanded: widget.makeItExpanded,
            backgroundColor: isClicked
                ? ColorManager(context).grey1
                : ColorManager(context).black,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 1),
              child: isClicked
                  ? _SubscribedWidgets(widget.fontSize)
                  : Text(
                      "Subscribe",
                      style: getMediumStyle(
                          color: ColorManager(context).white,
                          fontSize: widget.fontSize),
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
  const _SubscribedWidgets(this.fontSize);
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgIcon(IconsAssets.notificationIcon, size: fontSize + 5),
        const RSizedBox(width: 5),
        SvgIcon(IconsAssets.downArrowIcon, size: fontSize + 5)
      ],
    );
  }
}
