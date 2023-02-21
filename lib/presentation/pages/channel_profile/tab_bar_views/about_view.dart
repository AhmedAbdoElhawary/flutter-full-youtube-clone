import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/channel_details/channel_sub_details/channel_sub_details_extension.dart';

class TabBarAboutView extends StatelessWidget {
  const TabBarAboutView(this.channelItem, {Key? key}) : super(key: key);
  final ChannelDetailsItem? channelItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description",
                style: getBoldStyle(
                    color: ColorManager(context).black, fontSize: 20)),
            _space,
            Text(
              channelItem?.getBio()??"",
              style: getNormalStyle(
                  color: ColorManager(context).black, fontSize: 13),
            ),
            _space,
            _space,
            Text("More info",
                style: getBoldStyle(
                    color: ColorManager(context).black, fontSize: 20)),
            _space,
            Row(
              children:  [
                const Icon(Icons.not_interested_sharp),
                const RSizedBox(width: 10),
                Text(channelItem?.getChannelCountry()??""),
              ],
            ),
            _space,
            Row(
              children:  [
                const Icon(Icons.info_outline_rounded),
                const RSizedBox(width: 10),
                Text("Joined ${channelItem?.getPublishedTime()}"),
              ],
            ),
            _space,
            Row(
              children:  [
                const Icon(Icons.compare_arrows),
                const RSizedBox(width: 10),
                Text("${channelItem?.getVideosViewsCount()} views"),
              ],
            ),
            _space,
          ],
        ),
      ),
    );
  }

  Widget get _space => const RSizedBox(height: 15);
}
