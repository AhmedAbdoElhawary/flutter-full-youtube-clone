part of '../shorts_page.dart';

class _VerticalButtons extends StatelessWidget {
  const _VerticalButtons({Key? key}) : super(key: key);

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
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 18.r,
                    backgroundColor: ColorManager(context).white,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      "@AhmedAbdo Ahm",
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
              "Caption " * 15,
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
  bool isClicked=false;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () async {
        setState(() {
          isClicked=!isClicked;
        });
      },
      child: Container(
        padding: REdgeInsets.all(4),
        decoration: BoxDecoration(
            color:isClicked?ColorManager(context).black26: ColorManager.blackRed,
            borderRadius: BorderRadius.circular(2.r)),
        child: Text(
          isClicked?"SUBSCRIBED":"SUBSCRIBE",
          style:
              getMediumStyle(color:ColorManager(context).white, fontSize: 13),
        ),
      ),
    );
  }
}
