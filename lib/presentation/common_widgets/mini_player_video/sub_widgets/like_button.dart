part of '../mini_player_video.dart';

class _LikeButton extends StatelessWidget {
  const _LikeButton();

  @override
  Widget build(BuildContext context) {
    final miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");
    VideoDetailsItem? videoDetails = miniVideoViewLogic.selectedVideoDetails;
    String videoId = videoDetails?.id ?? "";
    if (videoId.isEmpty) {
      return _LikeIconButton(videoId: videoId, videoDetails: videoDetails);
    } else {
      return BlocBuilder<SingleVideoCubit, SingleVideoState>(
        bloc: BlocProvider.of<SingleVideoCubit>(context)
          ..getVideoRating(videoId: videoId),
        builder: (context, state) => state.maybeWhen(
          getVideoRatingLoaded: (ratingDetails) {
            return _LikeIconButton(
              videoId: videoId,
              ratingDetails: ratingDetails,
              videoDetails: videoDetails,
            );
          },
          loading: () => const _InteractionShimmerLoading(),
          error: (error) {
            ToastShow.reformatToast(context, error.error);
            return _LikeIconButton(
              videoId: videoId,
              videoDetails: videoDetails,
            );
          },
          orElse: () => _LikeIconButton(
            videoId: videoId,
            videoDetails: videoDetails,
          ),
        ),
      );
    }
  }
}

class _LikeIconButton extends StatefulWidget {
  const _LikeIconButton(
      {required this.videoId, this.ratingDetails, required this.videoDetails});
  final RatingDetails? ratingDetails;
  final String videoId;
  final VideoDetailsItem? videoDetails;
  @override
  State<_LikeIconButton> createState() => _LikeIconButtonState();
}

class _LikeIconButtonState extends State<_LikeIconButton> {
  @override
  Widget build(BuildContext context) {
    bool isLiked = widget.ratingDetails?.rating == Rating.like;

    return InkWell(
      onTap: () {
        if (widget.videoId.isNotEmpty) {
          SingleVideoCubit.get(context).rateThisVideo(
              videoId: widget.videoId,
              rating: isLiked ? Rating.non : Rating.dislike);

          setState(() => isLiked = !isLiked);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.thumb_up_alt_rounded,
              color: isLiked ? ColorManager.blue : null),
          const RSizedBox(height: 5),
          Text(
            widget.ratingDetails == null
                ? ""
                : widget.videoDetails?.getVideoLikesCount() ?? "Like",
            style: getNormalStyle(
                color: ColorManager(context).black, fontSize: 13),
          )
        ],
      ),
    );
  }
}
