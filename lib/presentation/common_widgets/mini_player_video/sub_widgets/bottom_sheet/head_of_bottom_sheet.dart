part of '../../mini_player_video.dart';

class _HeadOfBottomSheet extends StatelessWidget {
  const _HeadOfBottomSheet({this.headTitle = "Description", Key? key})
      : super(key: key);
  final String headTitle;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 10),
            child: Container(
              width: 45,
              height: 4.5,
              decoration: BoxDecoration(
                color: ColorManager(context).grey2,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  headTitle,
                  style: getBoldStyle(
                      color: ColorManager(context).black, fontSize: 18),
                ),
                InkWell(
                    onTap: () {
                      Go(context).back();
                    },
                    child: Container(
                        padding: REdgeInsets.all(5),
                        color: BaseColorManager.transparent,
                        child: const SvgIcon(IconsAssets.closeIcon, size: 25))),
              ],
            ),
          ),
          Divider(color: ColorManager(context).grey2, height: 1),
        ],
      ),
    );
  }
}
