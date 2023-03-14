part of'../../mini_player_video.dart';


class _BodyOfDescriptionSheet extends StatelessWidget {
  const _BodyOfDescriptionSheet();

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MiniVideoViewLogic>(tag: "1");
    VideoDetailsItem? videoDetails = logic.getSelectedVideoDetails;
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RSizedBox(height: 15),
              Text(
                videoDetails?.getVideoTitle() ?? "",
                style: getBoldStyle(
                    color: ColorManager(context).black, fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
              ),
              const RSizedBox(height: 5),
              const _CircularImageWithName(),
              const RSizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _NumberInfoAndTextBellow(
                      videoDetails?.getVideoLikesCount() ?? "", "Likes"),
                  _NumberInfoAndTextBellow(
                      videoDetails?.getVideoViewsCount() ?? "", "Views"),
                  _NumberInfoAndTextBellow(
                      videoDetails?.getVideoPublishedTime() ?? "", "Date"),
                ],
              ),
              Padding(
                padding: REdgeInsets.symmetric(vertical: 15),
                child: Divider(color: ColorManager(context).grey2, height: 1),
              ),
              TextLinks(
                videoDetails?.getVideoDescription() ?? "",
                style: getNormalStyle(
                    color: ColorManager(context).black, fontSize: 13),
              ),
              const RSizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }
}


class _CircularImageWithName extends StatelessWidget {
  const _CircularImageWithName();

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MiniVideoViewLogic>(tag: "1");
    VideoDetailsItem? videoDetails = logic.getSelectedVideoDetails;
    return Row(
      children: [
        CircularProfileImage(
          imageUrl: videoDetails?.getChannelProfileImageUrl() ?? "",
          radius: 15,
          channelDetailsItem: videoDetails?.getChannelSubDetails(),
          channelId: videoDetails?.getChannelId() ?? "",
        ),
        const RSizedBox(width: 10),
        Text(
          videoDetails?.getChannelName() ?? "",
          style:
          getMediumStyle(color: ColorManager(context).black, fontSize: 15),
        ),
      ],
    );
  }
}


class _NumberInfoAndTextBellow extends StatelessWidget {
  const _NumberInfoAndTextBellow(this.numberText, this.bellowText);
  final String numberText;
  final String bellowText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          numberText,
          style: getBoldStyle(color: ColorManager(context).black, fontSize: 18),
        ),
        const RSizedBox(height: 5),
        Text(
          bellowText,
          style:
          getNormalStyle(color: ColorManager(context).grey6, fontSize: 12),
        ),
      ],
    );
  }
}
