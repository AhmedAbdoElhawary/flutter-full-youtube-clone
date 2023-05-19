import 'package:flutter/material.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';
import 'package:youtube/presentation/pages/search/search_page.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({this.makeItBlack = true, Key? key}) : super(key: key);
  final bool makeItBlack;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Go(context).to(const SearchPage());
      },
      child: SvgIcon(
        IconsAssets.searchIcon,
        size: 20,
        color: makeItBlack ? null : BaseColorManager.white,
      ),
    );
  }
}
