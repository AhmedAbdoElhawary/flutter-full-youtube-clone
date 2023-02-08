import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/presentation/widgets/circular_profile_image.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../widgets/subscribe_button.dart';
import 'profile_page.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const ProfilePage(
        isThatMyPersonalId: true,
        widgetsAboveBio: _ButtonsAboveBio(),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leadingWidth: 60.w,
      backgroundColor: ColorManager(context).white,
      actions: [
        const _FavoriteIconButton(),
        Padding(
            padding: REdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(IconsAssets.menuPointsVerticalIcon)),
      ],
    );
  }
}

class _FavoriteIconButton extends StatefulWidget {
  const _FavoriteIconButton({
    Key? key,
  }) : super(key: key);

  @override
  State<_FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<_FavoriteIconButton> {
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            favorite = !favorite;
          });
        },
        child: favorite
            ? const Icon(Icons.favorite_rounded, color: ColorManager.blackRed)
            : const Icon(Icons.favorite_border_rounded));
  }
}

class _ButtonsAboveBio extends StatelessWidget {
  const _ButtonsAboveBio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: double.infinity, height: 90.h, color: ColorManager.green),
        const RSizedBox(height: 10),
        const CircularProfileImage(enableTapping: false, radius: 30),
        const RSizedBox(height: 15),
        Text(
          "Ahmed Abdo أحمد عبده",
          style: getBoldStyle(color: ColorManager(context).black, fontSize: 22),
        ),
        const RSizedBox(height: 10),
        const SubscribeButton(fontSize: 15),
        const RSizedBox(height: 5),
        Text(
          "@AhmedElhawary . 70.5k subscribers . 185 videos",
          style:
              getNormalStyle(color: ColorManager(context).black, fontSize: 12),
        ),
        const RSizedBox(height: 5),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 15),
          child: GestureDetector(
              onTap: () {
                /// TODO: push to about page
              },
              child: Text(
                "This is a bio " * 20,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: getNormalStyle(
                    color: ColorManager(context).grey, fontSize: 12),
              )),
        )
      ],
    );
  }
}
