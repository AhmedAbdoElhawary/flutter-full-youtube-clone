part of '../mini_player_video.dart';

class _LoadingWidgets extends StatelessWidget {
  const _LoadingWidgets();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _VideoTitleLoadingWidgets(),
          _ChannelNameLoadingWidgets(),
          _InteractionsLoadingWidgets(),
          ContainerLoading(height: 70, radius: 10),
          RSizedBox(height: 15),
          VideosListLoading(neverScroll: true),
        ],
      ),
    );
  }
}

class _VideoTitleLoadingWidgets extends StatelessWidget {
  const _VideoTitleLoadingWidgets();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(left: 15, top: 15, right: 15),
      child: Container(
        height: 70.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: ColorManager(context).grey1,
            borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContainerLoading(color: ColorManager(context).grey2),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 15),
              child: ContainerLoading(
                  width: 150,
                  color: ColorManager(context).grey2,
                  noPadding: true),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChannelNameLoadingWidgets extends StatelessWidget {
  const _ChannelNameLoadingWidgets();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(left: 15, top: 15, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 17.r, backgroundColor: ColorManager(context).grey1),
          const RSizedBox(width: 10),
          const ContainerLoading(width: 150, noPadding: true),
          const Spacer(),
          const InteractionShimmerLoading(width: 70, withoutPadding: true),
        ],
      ),
    );
  }
}

class _InteractionsLoadingWidgets extends StatelessWidget {
  const _InteractionsLoadingWidgets();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        children: [
          ...List.generate(
              4,
              (index) => InteractionShimmerLoading(
                    width: index != 0 ? 70 : 100,
                  )),
        ],
      ),
    );
  }
}
