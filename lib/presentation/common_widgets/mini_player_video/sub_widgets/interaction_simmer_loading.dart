part of '../mini_player_video.dart';

class _InteractionShimmerLoading extends StatelessWidget {
  const _InteractionShimmerLoading();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: ColorManager(context).grey1,
          highlightColor: ColorManager(context).greyPoint5,
          child: Container(
            width: 130.w,
            height: 30.h,
            decoration: BoxDecoration(
                color: ColorManager(context).grey2,
                borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ],
    );
  }
}
