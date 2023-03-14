part of '../mini_player_video.dart';

class _FirstCommentPreviewButton extends StatelessWidget {
  const _FirstCommentPreviewButton();

  @override
  Widget build(BuildContext context) {
    final miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");
    String commentCount =
        miniVideoViewLogic.getSelectedVideoDetails?.getVideoCommentsCount() ??
            "0";
    return InkWell(
      onTap: () {
        draggableBottomSheet(context, isThatDescription: false);
      },
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Comments $commentCount",
                  style: getNormalStyle(
                      color: ColorManager(context).black, fontSize: 15),
                ),
                const Icon(Icons.keyboard_arrow_down_outlined),
              ],
            ),
            const RSizedBox(height: 10),
            const _FirstComment()
          ],
        ),
      ),
    );
  }
}

class _FirstComment extends StatelessWidget {
  const _FirstComment();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MiniVideoViewLogic>(
      tag: "1",
      id: "update-selected-video",
      builder: (controller) {
        final String videoId = controller.getSelectedVideoDetails?.id ?? "";
        return BlocBuilder<SingleVideoCubit, SingleVideoState>(
          bloc: BlocProvider.of<SingleVideoCubit>(context)
            ..getFirstComment(videoId),
          buildWhen: (previous, current) =>
              previous != current && current is FirstCommentLoaded,
          builder: (context, state) {
            return state.maybeWhen(
                firstCommentLoaded: (firstCommentDetails) {
                  if (firstCommentDetails.items?.isEmpty ?? true) {
                    return const SizedBox();
                  }
                  SubCommentSnippet? snippet = firstCommentDetails
                      .items?[0]?.snippet?.topLevelComment?.snippet;

                  return _FirstCommentBody(snippet: snippet);
                },
                loading: () => const SizedBox(),
                orElse: () => const SizedBox());
          },
        );
      },
    );
  }
}

class _FirstCommentBody extends StatelessWidget {
  const _FirstCommentBody({required this.snippet});

  final SubCommentSnippet? snippet;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProfileImage(
            imageUrl: snippet?.authorProfileImageUrl ?? "",
            channelId: snippet?.authorChannelId?.value ?? ""),
        const RSizedBox(width: 10),
        Flexible(
          child: Text(
            snippet?.textOriginal ?? "",
            style: getNormalStyle(
                color: ColorManager(context).black, fontSize: 13),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
