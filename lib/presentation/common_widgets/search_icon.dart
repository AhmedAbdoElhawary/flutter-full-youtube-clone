import 'package:flutter/material.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';
import 'package:youtube/presentation/pages/search/search_page.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        enableFeedback: true,
        onTap: () {
          Go(context).to(const SearchPage());
        },
        child:const SvgIcon(IconsAssets.searchIcon,height: 20));
  }
}
