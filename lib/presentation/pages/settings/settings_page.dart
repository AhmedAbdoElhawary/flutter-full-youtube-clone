import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/config/themes/theme_service.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/presentation/common_widgets/app_bars/custom_app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(context).normalAppBar("Settings", withoutIcons: true),
      body: ListView.separated(
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  ThemeOfApp().switchTheme();
                },
                child: Text(
                  "General",
                  style: getNormalStyle(
                      color: ColorManager(context).black, fontSize: 15),
                ),
              ),
          separatorBuilder: (context, index) => const RSizedBox(height: 20),
          itemCount: 5),
    );
  }
}
