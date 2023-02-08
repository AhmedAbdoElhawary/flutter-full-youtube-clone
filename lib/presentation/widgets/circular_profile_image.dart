import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/presentation/pages/profile_page/user_profile_page.dart';

import '../../core/resources/color_manager.dart';

class CircularProfileImage extends StatelessWidget {
  final bool enableTapping;
  final double radius;
  const CircularProfileImage({this.enableTapping = true,this.radius=18, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !enableTapping
          ? null
          : () {
              Go(context).to(const UserProfilePage());
            },
      child: CircleAvatar(
        radius: radius.r,
        backgroundColor: ColorManager(context).grey,
      ),
    );
  }
}
