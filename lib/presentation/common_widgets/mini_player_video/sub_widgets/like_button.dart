part of '../mini_player_video.dart';

class _LikeButton extends StatelessWidget {
  const _LikeButton();

  @override
  Widget build(BuildContext context) {
    final miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");
    VideoDetailsItem? videoDetails = miniVideoViewLogic.getSelectedVideoDetails;
    String videoId = videoDetails?.id ?? "";
    if (videoId.isEmpty) {
      return _LikeIconButton(videoId: videoId, videoDetails: videoDetails);
    } else {
      return BlocBuilder<SingleVideoCubit, SingleVideoState>(
        bloc: BlocProvider.of<SingleVideoCubit>(context)
          ..getVideoRating(videoId: videoId),
        builder: (context, state) {
          return _LikeIconButton(
            videoId: videoId,
            ratingDetails:
                state is GetVideoRatingLoaded ? state.ratingDetails : null,
            videoDetails: videoDetails,
          );
        },
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
  String likeText = "";
  @override
  void initState() {
    super.initState();

    likeText = widget.videoDetails?.getVideoLikesCount() ?? "Like";
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MiniVideoViewLogic>(
      tag: "1",
      id: "update-video-rating",
      builder: (controller) {
        return Padding(
          padding: REdgeInsetsDirectional.only(start: 35, end: 3, top: 15),
          child: InkWell(
            onTap: () {
              if (widget.videoId.isNotEmpty) {
                String rating =
                    widget.ratingDetails?.rating != "none" ? "none" : "like";
                SingleVideoCubit.get(context)
                    .rateThisVideo(videoId: widget.videoId, rating: rating);

                controller.selectedVideoRating = rating;
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                controller.selectedVideoRating != "like"
                    ? const SvgIcon(IconsAssets.likeIcon)
                    : const SvgIcon(IconsAssets.likeColoredIcon),
                const RSizedBox(height: 5),
                Text(
                  likeText,
                  style: getNormalStyle(
                      color: ColorManager(context).black, fontSize: 13),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
