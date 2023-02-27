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
      // bloc: ChannelDetailsCubit.get(context)..subscribeToChannel(channelId),
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            setState(() => isClicked = !isClicked);
          },
          child: isClicked
              ? Row(
                  children: [
                    Text(
                      "SUBSCRIBED",
                      style: getMediumStyle(
                          color: ColorManager(context).white, fontSize: 15),
                    ),
                    const RSizedBox(width: 10),
                    Icon(
                      Icons.notifications_active_rounded,
                      color: ColorManager(context).black54,
                    )
                  ],
                )
              : Text(
                  "SUBSCRIBE",
                  style: getMediumStyle(
                      color: ColorManager(context).white, fontSize: 15),
                ),
        );
      },
    );
  }
}
