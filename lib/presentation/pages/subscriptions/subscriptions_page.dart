import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/presentation/common_widgets/sliver_app_bar.dart';

import '../../../core/resources/styles_manager.dart';
import 'logic/subscriptions_page_logic.dart';

class SubscriptionsPage extends StatelessWidget {
  const SubscriptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          MainSliverAppBar(
              preferredSizeWidget: PreferredSize(
                  preferredSize: Size.fromHeight(130.h),
                  child: const SubscriptionsBottomAppBarWidget())),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 30,
            (context, index) => Padding(
              padding: REdgeInsets.only(bottom: 15),
              child: const RSizedBox(),
            ),
          ),),
        ],),
      ),
    );
  }
}

class SubscriptionsBottomAppBarWidget extends StatelessWidget {
  const SubscriptionsBottomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SubscriptionsPageLogic(), tag: "1");
    return Container(
      width: MediaQuery.of(context).size.width,
      color: ColorManager(context).white,
      height: 130.h,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Row(
                children: [
                  const Flexible(child: _ChannelsCircularImage()),
                  RSizedBox(width: 55.w),
                ],
              ),
              const _AllChannelsTextButton(),
            ],
          ),
          const RSizedBox(height: 10),
          const _BottomChannelsWidget(),
        ],
      ),
    );
  }
}

class _BottomChannelsWidget extends StatelessWidget {
  const _BottomChannelsWidget();

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SubscriptionsPageLogic>(tag: "1");
    return Obx(() {
      switch (logic.selectedChannelIndex.value) {
        case null:
          return const Flexible(child: _FilteredOptions());
        default:
          return Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: InkWell(
                onTap: () {},
                child: Text(
                  "VIEW CHANNELS",
                  style: getMediumStyle(
                      color: ColorManager.darkBlue, fontSize: 13),
                ),
              ),
            ),
          );
      }
    });
  }
}

class _AllChannelsTextButton extends StatelessWidget {
  const _AllChannelsTextButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55.w,
      height: 85.h,
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

class _ChannelsCircularImage extends StatelessWidget {
  const _ChannelsCircularImage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => _ChannelItem(index),
        separatorBuilder: (context, index) => const RSizedBox(width: 5),
        itemCount: 50,
      ),
    );
  }
}

class _ChannelItem extends StatelessWidget {
  const _ChannelItem(this.index);
  final int index;
  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SubscriptionsPageLogic>(tag: "1");
    return Padding(
      padding: REdgeInsetsDirectional.only(
          start: index == 0 ? 10 : 0, end: index == 49 ? 10 : 0),
      child: InkWell(
        onTap: () => logic.selectedChannelIndex.value = index,
        child: Obx(
          () {
            int? selectedIndex = logic.selectedChannelIndex.value;
            return Container(
              padding: REdgeInsetsDirectional.only(start: 5, end: 5),
              color: selectedIndex != null && selectedIndex == index
                  ? ColorManager.lightBlue
                  : null,
              width: 65.w,
              child: selectedIndex == index || selectedIndex == null
                  ? const _ChannelImageName()
                  : const ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Color.fromARGB(48, 180, 180, 180),
                          BlendMode.modulate),
                      child: _ChannelImageName()),
            );
          },
        ),
      ),
    );
  }
}

class _ChannelImageName extends StatelessWidget {
  const _ChannelImageName();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(radius: 30, backgroundColor: ColorManager(context).grey2),
        const RSizedBox(height: 5),
        const _ChannelName()
      ],
    );
  }
}

class _ChannelName extends StatelessWidget {
  const _ChannelName();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        "Ahmed Abdo" * 2,
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
