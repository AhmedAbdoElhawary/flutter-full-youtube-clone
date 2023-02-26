import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/presentation/cubit/channel/channel_details_cubit.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/styles_manager.dart';


class SubscribeButton extends StatefulWidget {
  const SubscribeButton({this.fontSize = 17, Key? key}) : super(key: key);
  final double fontSize;

  @override
  State<SubscribeButton> createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<SubscribeButton> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelDetailsCubit, ChannelDetailsState>(
      bloc: ChannelDetailsCubit.get(context)..subscribeToChannel(channelId),
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            setState(() => isClicked = !isClicked);
          },
          child: Container(
            padding: REdgeInsets.all(4),
            decoration: BoxDecoration(
                color: isClicked
                    ? ColorManager(context).black26
                    : ColorManager.blackRed,
                borderRadius: BorderRadius.circular(2.r)),
            child: Text(
              isClicked ? "SUBSCRIBED" : "SUBSCRIBE",
              style:
              getMediumStyle(color: ColorManager(context).white, fontSize: 13),
            ),
          ),
        );
      },
    );
  }
}
