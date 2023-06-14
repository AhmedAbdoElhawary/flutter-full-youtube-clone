import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/font_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      primaryColor: BaseColorManager.white,
      primaryColorLight: BaseColorManager.grey1,
      hintColor: BaseColorManager.grey2,
      shadowColor: BaseColorManager.veryLowOpacityGrey,
      focusColor: BaseColorManager.black,
      disabledColor: BaseColorManager.grey7,
      dialogBackgroundColor: BaseColorManager.black87,
      hoverColor: BaseColorManager.black45,
      indicatorColor: BaseColorManager.black38,
      dividerColor: BaseColorManager.black12,
      scaffoldBackgroundColor: BaseColorManager.white,
      iconTheme: const IconThemeData(color: BaseColorManager.black),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: BaseColorManager.black,
        unselectedItemColor: BaseColorManager.black,
        selectedIconTheme: const IconThemeData(size: 24),
        unselectedIconTheme: const IconThemeData(size: 24),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle:
            getNormalStyle(color: BaseColorManager.black, fontSize: 11),
        unselectedLabelStyle:
            getNormalStyle(color: BaseColorManager.black, fontSize: 11),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
      elevatedButtonTheme: elevatedButtonThemeData(),
      chipTheme: const ChipThemeData(
          backgroundColor: BaseColorManager.veryLowOpacityGrey),
      canvasColor: BaseColorManager.transparent,
      splashColor: BaseColorManager.white,
      appBarTheme: appBarTheme(),
      tabBarTheme: tabBarTheme(),
      textTheme: textTheme(),
      bottomAppBarTheme:
          const BottomAppBarTheme(color: BaseColorManager.black26),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
          .copyWith(background: BaseColorManager.lightBlack)
          .copyWith(error: BaseColorManager.black),
    );
  }

  static ElevatedButtonThemeData elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (_) => BaseColorManager.black,
        ),
        minimumSize:
            MaterialStateProperty.all<Size>(const Size(double.infinity, 0)),
        padding: MaterialStateProperty.all<REdgeInsets>(REdgeInsets.all(8)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
      ),
    );
  }

  static TabBarTheme tabBarTheme() {
    return TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      labelPadding: REdgeInsets.all(0),
      indicator: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: BaseColorManager.black54, width: 1.5),
        ),
      ),
      labelColor: BaseColorManager.black,
      unselectedLabelColor: BaseColorManager.grey,
    );
  }

  static TextTheme textTheme() {
    return TextTheme(
      bodyLarge: getNormalStyle(color: BaseColorManager.black, fontSize: 25),
      bodyMedium: getNormalStyle(color: BaseColorManager.black, fontSize: 15),
      bodySmall: getMediumStyle(color: BaseColorManager.black, fontSize: 15),
      titleSmall: getNormalStyle(color: BaseColorManager.black, fontSize: 13),
      labelSmall: getMediumStyle(color: BaseColorManager.grey, fontSize: 13),
      displayLarge: getMediumStyle(color: BaseColorManager.grey, fontSize: 12),
      displayMedium: getMediumStyle(color: BaseColorManager.grey, fontSize: 11),
      displaySmall: getMediumStyle(color: BaseColorManager.grey, fontSize: 10),
      headlineLarge: getNormalStyle(color: BaseColorManager.grey7),
      headlineMedium: getNormalStyle(color: BaseColorManager.grey3),
      headlineSmall: getNormalStyle(color: BaseColorManager.greyPoint5),
      labelLarge: getNormalStyle(color: BaseColorManager.grey1Point5),
      labelMedium: getNormalStyle(color: BaseColorManager.grey),
      titleLarge: getNormalStyle(color: BaseColorManager.grey8),
      titleMedium: getNormalStyle(color: BaseColorManager.grey6),
    );
  }

  static AppBarTheme appBarTheme() {
    return AppBarTheme(
      elevation: 0,
      toolbarHeight: 56.r,
      titleSpacing: 0,
      color: BaseColorManager.white,
      iconTheme: const IconThemeData(color: BaseColorManager.black),
      titleTextStyle:
          getNormalStyle(fontSize: FontSize.s16, color: BaseColorManager.black),
    );
  }

  static OutlinedButtonThemeData outlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: getMediumStyle(fontSize: 17, color: BaseColorManager.black),
        padding: REdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        side: const BorderSide(width: 1, color: BaseColorManager.black45),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      primaryColor: BaseColorManager.black,
      primaryColorLight: BaseColorManager.black54,
      hintColor: BaseColorManager.grey9,
      shadowColor: BaseColorManager.darkGray,
      focusColor: BaseColorManager.white,
      dialogBackgroundColor: BaseColorManager.white,
      hoverColor: BaseColorManager.grey,
      indicatorColor: BaseColorManager.grey,
      dividerColor: BaseColorManager.grey,
      iconTheme: const IconThemeData(color: BaseColorManager.white),
      chipTheme:
          const ChipThemeData(backgroundColor: BaseColorManager.lightDarkGray),
      disabledColor: BaseColorManager.grey2,
      scaffoldBackgroundColor: BaseColorManager.black,
      canvasColor: BaseColorManager.transparent,
      splashColor: BaseColorManager.darkGray,
      appBarTheme: AppBarTheme(
        elevation: 0,
        toolbarHeight: 56.r,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: BaseColorManager.white),
        color: BaseColorManager.black,
        shadowColor: BaseColorManager.black54,
        titleTextStyle: getNormalStyle(
            fontSize: FontSize.s16, color: BaseColorManager.white),
      ),
      tabBarTheme: TabBarTheme(
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: BaseColorManager.white,
        dividerColor: BaseColorManager.white,
        labelPadding: REdgeInsets.all(0),
        indicator: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: BaseColorManager.white, width: 1.5),
          ),
        ),
        labelColor: BaseColorManager.black,
        unselectedLabelColor: BaseColorManager.grey3,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (_) => BaseColorManager.white,
          ),
          minimumSize:
              MaterialStateProperty.all<Size>(const Size(double.infinity, 0)),
          padding: MaterialStateProperty.all<REdgeInsets>(REdgeInsets.all(8)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: getNormalStyle(color: BaseColorManager.white),
        bodyMedium: getNormalStyle(color: BaseColorManager.white),
        bodySmall: getNormalStyle(color: BaseColorManager.white),
        displayLarge:
            getNormalStyle(color: BaseColorManager.white, fontSize: 15),
        displayMedium:
            getBoldStyle(color: BaseColorManager.white, fontSize: 15),
        displaySmall:
            getMediumStyle(color: BaseColorManager.white, fontSize: 15),
        titleSmall: getNormalStyle(color: BaseColorManager.white),
        headlineLarge: getNormalStyle(color: BaseColorManager.grey9),
        headlineMedium: getNormalStyle(color: BaseColorManager.grey9),
        headlineSmall: getNormalStyle(color: BaseColorManager.grey9),
        labelLarge: getNormalStyle(color: BaseColorManager.grey),
        labelMedium: getNormalStyle(color: BaseColorManager.white),
        titleLarge: getNormalStyle(color: BaseColorManager.grey9),
        titleMedium: getNormalStyle(color: BaseColorManager.grey9),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(color: BaseColorManager.grey),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
          .copyWith(background: BaseColorManager.darkGray)
          .copyWith(error: BaseColorManager.grey),
    );
  }
}
