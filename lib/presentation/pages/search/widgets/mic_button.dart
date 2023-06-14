import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_manager.dart';

class MicIconButton extends StatelessWidget {
  const MicIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: ColorManager(context).grey1),
      padding: REdgeInsets.all(6),
      child: const Icon(Icons.mic_rounded, size: 22),
    );
  }
}
