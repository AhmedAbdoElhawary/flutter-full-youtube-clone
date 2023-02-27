part of '../../mini_player_video.dart';

class _BodyOfCommentsSheet extends StatelessWidget {
  const _BodyOfCommentsSheet();

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MiniVideoViewLogic>(tag: "1");
    VideoDetailsItem? videoDetails = logic.selectedVideoDetails;
    return Material(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        itemBuilder: (context, index) => Padding(
          padding: REdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: Row(
            children: [
              const CircleAvatar(
                  radius: 15, backgroundColor: ColorManager.teal),
              const RSizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Ahmed Abdo . 1mo ago",
                      style: getNormalStyle(
                          color: ColorManager(context).grey6, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      "Comment " * 30,
                      style: getNormalStyle(
                          color: ColorManager(context).black, fontSize: 15),
                    ),
                    const RSizedBox(height: 10),
                    Row(
                      children: const [
                        Icon(Icons.thumb_up_off_alt_outlined, size: 10),
                        RSizedBox(width: 30),
                        Icon(Icons.thumb_down_off_alt_outlined, size: 10),
                        RSizedBox(width: 30),
                        Icon(Icons.insert_comment_sharp, size: 10),
                      ],
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(IconsAssets.menuPointsVerticalIcon, height: 10),
            ],
          ),
        ),
        itemCount: 20,
      ),
    );
  }
}
