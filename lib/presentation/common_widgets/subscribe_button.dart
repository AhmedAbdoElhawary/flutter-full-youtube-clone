import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/presentation/common_widgets/rounded_button.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';
import 'package:youtube/presentation/cubit/channel/channel_details_cubit.dart';
import 'package:youtube/presentation/pages/subscriptions/logic/subscriptions_page_logic.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/styles_manager.dart';

class SubscribeButton extends StatefulWidget {
  const SubscribeButton(
      {this.fontSize = 15,
      this.makeItExpanded = true,
      required this.channelItem,
      Key? key})
      : super(key: key);
  final double fontSize;
  final ChannelDetailsItem? channelItem;
  final bool makeItExpanded;

  @override
  State<SubscribeButton> createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<SubscribeButton> {
  final logic = Get.find<SubscriptionsPageLogic>(tag: "1");
  bool isSubscribed = false;
  int? channelIndex;
  String? channelId;
  @override
  void didUpdateWidget(covariant SubscribeButton oldWidget) {
    channelId = widget.channelItem?.id ?? "";
    channelIndex = logic.allSubscribedChannelsIds
        .indexWhere((element) => element == channelId);
    isSubscribed = channelIndex != null && channelIndex != -1;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelDetailsCubit, ChannelDetailsState>(
      builder: (context, state) {
        return RoundedButton(
            makeItExpanded: widget.makeItExpanded,
            backgroundColor: isSubscribed
                ? ColorManager(context).grey1
                : ColorManager(context).black,
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 3, vertical: 1),
              child: isSubscribed
                  ? _SubscribedWidgets(widget.fontSize)
                  : Text(
                      "Subscribe",
                      style: getMediumStyle(
                          color: ColorManager(context).white,
                          fontSize: widget.fontSize),
                    ),
            ),
            onTap: () async {
              ChannelDetailsCubit cubit = ChannelDetailsCubit.get(context);
              if (isSubscribed) {
                await cubit.deleteSubscription(
                    subscriptionId: logic.allSubscribedIds[channelIndex ?? 0]);
              } else {
                await cubit.subscribeToChannel(channelId: channelId ?? "");
              }
              await cubit.getMySubscriptionsChannels();

              setState(() {
                isSubscribed =
                    logic.allSubscribedChannelsIds.contains(channelId);
              });
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
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgIcon(IconsAssets.notificationIcon, size: fontSize + 5),
        const RSizedBox(width: 5),
        SvgIcon(IconsAssets.downArrowIcon, size: fontSize + 5)
      ],
    );
  }
}
