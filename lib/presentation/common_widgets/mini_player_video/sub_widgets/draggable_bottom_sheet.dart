part of '../mini_player_video.dart';

Future<void> draggableBottomSheet(BuildContext context,
    {bool isThatDescription = true}) async {
  final logic = Get.find<MiniVideoViewLogic>(tag: "1");

  return showSlidingBottomSheet<void>(
    context,
    builder: (BuildContext context) => SlidingSheetDialog(
      cornerRadius: 16,
      controller: logic.descriptionSheetController,
      backdropColor: BaseColorManager.transparent,
      minHeight: 200.h,
      color: Theme.of(context).splashColor,
      dismissOnBackdropTap: false,
      isBackdropInteractable: true,
      snapSpec: const SnapSpec(initialSnap: 0.695, snappings: [.7, 0.695, .97]),
      builder: (context, state) => isThatDescription
          ? const _BodyOfDescriptionSheet()
          : const _BodyOfCommentsSheet(),
      headerBuilder: (context, state) => _HeadOfBottomSheet(
        headTitle: isThatDescription ? "Description" : "Comments",
      ),
    ),
  );
}
