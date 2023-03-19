part of '../../mini_player_video.dart';

class _BodyOfCommentsSheet extends StatelessWidget {
  const _BodyOfCommentsSheet();

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MiniVideoViewLogic>(tag: "1");
    VideoDetailsItem? videoDetails = logic.getSelectedVideoDetails;
    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<SingleVideoCubit, SingleVideoState>(
          bloc: SingleVideoCubit.get(context)
            ..getAllComments(videoDetails?.id ?? ""),
          buildWhen: (previous, current) =>
              previous != current && current is AllCommentLoaded,
          builder: (context, state) {
            return state.maybeWhen(
                allCommentLoaded: (allCommentDetails) => ListView.builder(
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      itemBuilder: (context, index) =>
                          _CommentItem(allCommentDetails.items![index]),
                      itemCount: allCommentDetails.items?.length ?? 0,
                    ),
                videoInfoLoading: () => const ThineCircularProgress(),
                videoInfoError: (e) {
                  ToastShow.reformatToast(context, e.error);
                  return Center(
                    child: Text(
                        NetworkExceptions.getErrorMessage(e.networkExceptions)),
                  );
                },
                orElse: () => const SizedBox());
          },
        ),
      ),
    );
  }
}

class _CommentItem extends StatelessWidget {
  const _CommentItem(this.commentDetailsItem);
  final CommentDetailsItem? commentDetailsItem;
  @override
  Widget build(BuildContext context) {
    int? replyCount = commentDetailsItem?.getTotalReplyCount();
    return Padding(
      padding: REdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircularProfileImage(
            imageUrl: commentDetailsItem?.getAuthorProfileImageUrl() ?? "",
            radius: 15.r,
            enableTapping: false,
            channelId: commentDetailsItem?.getAuthorChannelId() ?? "",
          ),
          const RSizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${commentDetailsItem?.getAuthorDisplayName()} . ${commentDetailsItem?.getCommentPublishedTime()}",
                  style: getNormalStyle(
                      color: ColorManager(context).grey7, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const RSizedBox(height: 5),
                ReadMore(commentDetailsItem?.getCommentText() ?? ""),
                const RSizedBox(height: 10),
                _InteractCommentButtons(commentDetailsItem),
                const RSizedBox(height: 20),
                if ((replyCount ?? 0) > 0)
                  Text(
                    "$replyCount ${replyCount == 1 ? "REPLY" : "REPLIES"}",
                    style: getMediumStyle(
                        color: ColorManager.darkBlue, fontSize: 15),
                  )
              ],
            ),
          ),
          const SvgIcon(IconsAssets.menuPointsVerticalIcon, size: 10),
        ],
      ),
    );
  }
}

class _InteractCommentButtons extends StatelessWidget {
  const _InteractCommentButtons(this.commentDetailsItem);
  final CommentDetailsItem? commentDetailsItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.thumb_up_off_alt_outlined, size: 15),
        const RSizedBox(width: 5),
        Text(
          "${commentDetailsItem?.getLikeCount()}",
          style:
              getNormalStyle(color: ColorManager(context).black, fontSize: 12),
        ),
        const RSizedBox(width: 30),
        const Icon(Icons.thumb_down_off_alt_outlined, size: 15),
        const RSizedBox(width: 30),
        const Icon(Icons.insert_comment_sharp, size: 15),
      ],
    );
  }
}
