import 'package:flutter/material.dart';
import 'in_view_notifier.dart';
import 'in_view_state.dart';
import 'widget_data.dart';

class InViewNotifierCustomScrollView extends InViewNotifier {
  InViewNotifierCustomScrollView({
    Key? key,
    required List<Widget> slivers,
    List<String> initialInViewIds = const [],
    double endNotificationOffset = 0.0,
    VoidCallback? onListEndReached,
    Duration throttleDuration = const Duration(milliseconds: 200),
    Axis scrollDirection = Axis.vertical,
    required IsInViewPortCondition isInViewPortCondition,
    ScrollController? controller,
    ScrollPhysics? physics,
    bool reverse = false,
    bool? primary,
    bool shrinkWrap = false,
    Key? center,
    double anchor = 0.0,
  }) : super(
          key: key,
          initialInViewIds: initialInViewIds,
          endNotificationOffset: endNotificationOffset,
          onListEndReached: onListEndReached,
          throttleDuration: throttleDuration,
          isInViewPortCondition: isInViewPortCondition,
          child: CustomScrollView(
            slivers: slivers,
            anchor: anchor,
            controller: controller,
            scrollDirection: scrollDirection,
            physics: physics,
            reverse: reverse,
            primary: primary,
            shrinkWrap: shrinkWrap,
            center: center,
          ),
        );

  static InViewState? of(BuildContext context) {
    final InheritedInViewWidget widget = context
        .getElementForInheritedWidgetOfExactType<InheritedInViewWidget>()!
        .widget as InheritedInViewWidget;
    return widget.inViewState;
  }
}
