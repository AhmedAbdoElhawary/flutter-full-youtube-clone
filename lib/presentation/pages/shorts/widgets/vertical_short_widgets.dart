part of '../shorts_page.dart';

class _VerticalButtons extends StatelessWidget {
  const _VerticalButtons(this.videoDetailsItem, {Key? key}) : super(key: key);
  final VideoDetailsItem videoDetailsItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.only(end: 20.0, bottom: 20, start: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircularProfileImage(
                  radius: 18.r,
                  imageUrl: videoDetailsItem.getChannelProfileImageUrl(),
                  channelId: videoDetailsItem.getChannelId(),
                  channelDetailsItem: videoDetailsItem.getChannelSubDetails(),
                ),
                const RSizedBox(width: 10),
                Flexible(
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      videoDetailsItem.getCustomUserName(),
                      style: getNormalStyle(color: ColorManager(context).white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                const RSizedBox(width: 10),
                const Flexible(child: _SubscribeButton()),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: REdgeInsetsDirectional.only(end: 42.0),
            child: Text(
              videoDetailsItem.getVideoDescription(),
              style: getNormalStyle(color: ColorManager(context).white),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _SubscribeButton extends StatefulWidget {
  const _SubscribeButton({Key? key}) : super(key: key);

  @override
  State<_SubscribeButton> createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<_SubscribeButton> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isClicked = !isClicked;
        });
      },
      child: Container(
        padding: REdgeInsets.all(4),
        decoration: BoxDecoration(
            color: isClicked
                ? ColorManager(context).black26
                : ColorManager.blackRed,
            borderRadius: BorderRadius.circular(2.r)),
        child: Text(
          isClicked ? "SUBSCRIBED" : "SUBSCRIBE",
          style:
              getMediumStyle(color: ColorManager(context).white, fontSize: 13),
        ),
      ),
    );
  }
}
