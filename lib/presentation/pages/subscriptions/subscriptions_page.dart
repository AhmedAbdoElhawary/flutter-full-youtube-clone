import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/presentation/widgets/thumbnail_video.dart';

import '../../../core/resources/styles_manager.dart';

class SubscriptionsPage extends StatelessWidget {
  const SubscriptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          const _CustomSliverAppBar(),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 30,
            (context, index) => Padding(
              padding: REdgeInsets.only(bottom: 15),
              child: ThumbnailVideoItem(index),
            ),
          )),
        ]),
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  const _CustomSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leading: const Icon(Icons.yard_outlined, size: 40),
      actionsIconTheme: const IconThemeData(size: 20),
      actions: const [
        Icon(Icons.search_rounded, size: 25),
        RSizedBox(width: 20),
        Icon(Icons.search_rounded, size: 25),
        RSizedBox(width: 20),
        Icon(Icons.search_rounded, size: 25),
        RSizedBox(width: 20),
        CircleAvatar(backgroundColor: ColorManager.teal, radius: 13),
        RSizedBox(width: 20),
      ],
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(130.h),
          child: const _AppBarBottomWidget()),
    );
  }
}

class _AppBarBottomWidget extends StatelessWidget {
  const _AppBarBottomWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: ColorManager(context).white,
      height: 130.h,
      child: Column(
        children: [
          const RSizedBox(height: 5),
          Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: const [
              Flexible(child: _ChannelsCircularImage()),
              _AllChannelsTextButton(),
            ],
          ),
          const RSizedBox(height: 15),
          const Flexible(child: _FilteredOptions()),
        ],
      ),
    );
  }
}

class _AllChannelsTextButton extends StatelessWidget {
  const _AllChannelsTextButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55.w,
      height: 75.h,
      color: ColorManager(context).white,
      child: Center(
        child: Text(
          "ALL",
          style: getMediumStyle(color: ColorManager.darkBlue, fontSize: 15),
        ),
      ),
    );
  }
}

class _ChannelsCircularImage extends StatefulWidget {
  const _ChannelsCircularImage();

  @override
  State<_ChannelsCircularImage> createState() => __ChannelsCircularImageState();
}

class __ChannelsCircularImageState extends State<_ChannelsCircularImage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: REdgeInsetsDirectional.only(
              start: index == 0 ? 10 : 0, end: index == 19 ? 10 : 0),
          child: GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: SizedBox(
              width: 65.w,
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 30, backgroundColor: ColorManager(context).grey2),
                  const RSizedBox(height: 5),
                  const _ChannelName()
                ],
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => const RSizedBox(width: 10),
        itemCount: 20,
      ),
    );
  }
}

class _ChannelName extends StatelessWidget {
  const _ChannelName();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        "Ahmed Ab " * 2,
        style: getNormalStyle(color: ColorManager(context).grey7, fontSize: 12),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _FilteredOptions extends StatefulWidget {
  const _FilteredOptions();

  @override
  State<_FilteredOptions> createState() => _FilteredOptionsState();
}

class _FilteredOptionsState extends State<_FilteredOptions> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: REdgeInsetsDirectional.only(
              start: index == 0 ? 10 : 0, end: index == 5 ? 10 : 0),
          child: GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: _RoundedFilteredButton(
              isSelected: index == selectedIndex,
              text: "Today",
            ),
          ),
        ),
        separatorBuilder: (context, index) => const RSizedBox(width: 10),
        itemCount: 6,
      ),
    );
  }
}

class _RoundedFilteredButton extends StatelessWidget {
  const _RoundedFilteredButton({
    Key? key,
    required this.isSelected,
    required this.text,
  }) : super(key: key);
  final bool isSelected;

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: isSelected
              ? ColorManager(context).grey7
              : ColorManager(context).grey1,
          border: isSelected
              ? null
              : Border.all(color: ColorManager(context).grey4),
          borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        children: [
          Text(
            text,
            style: getNormalStyle(
                color: isSelected
                    ? ColorManager(context).white
                    : ColorManager(context).black,
                fontSize: 13),
          ),
        ],
      ),
    );
  }
}
