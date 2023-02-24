part of '../mini_player_video.dart';

class _DislikeButton extends StatelessWidget {
  const _DislikeButton();

  @override
  Widget build(BuildContext context) {
    final miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");
    VideoDetailsItem? videoDetails = miniVideoViewLogic.selectedVideoDetails;
    String videoId = videoDetails?.id ?? "";
    if (videoId.isEmpty) {
      return _DislikeIconButton(videoId: videoId, videoDetails: videoDetails);
    } else {
      return BlocBuilder<SingleVideoCubit, SingleVideoState>(
        bloc: BlocProvider.of<SingleVideoCubit>(context)
          ..getVideoRating(videoId: videoId),
        builder: (context, state) => state.maybeWhen(
          getVideoRatingLoaded: (ratingDetails) {
            return _DislikeIconButton(
              videoId: videoId,
              ratingDetails: ratingDetails,
              videoDetails: videoDetails,
            );
          },
          error: (error) {
            ToastShow.reformatToast(context, error.error);
            return _DislikeIconButton(
              videoId: videoId,
              videoDetails: videoDetails,
            );
          },
          orElse: () => _DislikeIconButton(
            videoId: videoId,
            videoDetails: videoDetails,
          ),
        ),
      );
    }
  }
}

class _DislikeIconButton extends StatefulWidget {
  const _DislikeIconButton(
      {required this.videoId, this.ratingDetails, required this.videoDetails});
  final RatingDetails? ratingDetails;
  final String videoId;
  final VideoDetailsItem? videoDetails;
  @override
  State<_DislikeIconButton> createState() => _DislikeIconButtonState();
}

class _DislikeIconButtonState extends State<_DislikeIconButton> {
  @override
  Widget build(BuildContext context) {
    bool isDisliked = widget.ratingDetails?.rating == Rating.dislike;

    return InkWell(
      onTap: () {
        if (widget.videoId.isNotEmpty) {
          SingleVideoCubit.get(context).rateThisVideo(
              videoId: widget.videoId,
              rating: isDisliked ? Rating.non : Rating.dislike);

          setState(() => isDisliked = !isDisliked);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.thumb_down_alt_rounded,
              color: isDisliked ? ColorManager.blue : null),
          const RSizedBox(height: 5),
          Text(
            widget.ratingDetails == null ? "" : "Dislike",
            style: getNormalStyle(
                color: ColorManager(context).black, fontSize: 13),
          )
        ],
      ),
    );
  }
}
