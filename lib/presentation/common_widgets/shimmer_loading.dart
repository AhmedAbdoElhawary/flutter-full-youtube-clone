import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube/core/resources/color_manager.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({required this.child, Key? key}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: ColorManager(context).grey1,
        highlightColor: ColorManager(context).greyPoint5,
        child: child);
  }
}
