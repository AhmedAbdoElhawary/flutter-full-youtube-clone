import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/config/themes/theme_service.dart';
import 'package:youtube/presentation/common_widgets/app_bars/custom_app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool isThatDark;
  @override
  void initState() {
    isThatDark = ThemeOfApp().isThemeDark();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(context).normalAppBar("Settings", withoutIcons: true),
      body: Align(
        alignment: AlignmentDirectional.topEnd,
        child: Padding(
          padding: REdgeInsets.all(15.0),
          child: CupertinoSwitch(
            value: isThatDark,
            onChanged: (value) {
              ThemeOfApp().switchTheme();
              setState(() => isThatDark = !isThatDark);
            },
          ),
        ),
      ),
    );
  }
}
