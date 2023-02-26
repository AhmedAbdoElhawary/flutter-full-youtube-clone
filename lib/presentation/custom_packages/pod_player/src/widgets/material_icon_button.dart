import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';

class MaterialIconButton extends StatelessWidget {
  const MaterialIconButton({
    Key? key,
    this.color,
    required this.child,
    this.radius = 12,
    required this.toolTipMsg,
    this.onPressed,
    this.onHover,
    this.onTapDown,
  }) : super(key: key);

  final Color? color;
  final Widget child;
  final double radius;
  final String toolTipMsg;
  final void Function()? onPressed;
  final void Function(bool)? onHover;
  final void Function(TapDownDetails details)? onTapDown;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      color: BaseColorManager.orange,
      surfaceTintColor: BaseColorManager.blue,
      shadowColor: BaseColorManager.yellow,
      shape: const CircleBorder(),
      child: Tooltip(
        message: toolTipMsg,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius * 4),
          onHover: onHover,
          onTap: onPressed,
          onTapDown: onTapDown,
          child: color == null
              ? _buildChild()
              : Padding(
                  padding: REdgeInsetsDirectional.only(
                      top: 12, end: 12, start: 12, bottom: 4),
                  child: _buildChild(),
                ),
        ),
      ),
    );
  }

  Widget _buildChild() {
    return IconTheme(
      data: IconThemeData(color: color, size: 24),
      child: child,
    );
  }
}
