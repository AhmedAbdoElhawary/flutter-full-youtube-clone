import 'package:flutter/material.dart';

class ColorManager {
  BuildContext context;
  ColorManager(this.context);

  Color get white => Theme.of(context).primaryColor;
  Color get greyPoint5 => Theme.of(context).hintColor;

  Color get grey1 => Theme.of(context).primaryColorLight;

  Color get grey1Point5 => Theme.of(context).textTheme.labelLarge!.color!;
  Color get grey2 => Theme.of(context).hintColor;

  Color get grey3 => Theme.of(context).textTheme.headlineMedium!.color!;
  Color get grey4 => Theme.of(context).hintColor;
  Color get grey => const Color.fromRGBO(158, 158, 158, 1);

  Color get grey6 => Theme.of(context).textTheme.titleMedium!.color!;
  Color get grey7 => Theme.of(context).textTheme.headlineLarge!.color!;

  Color get grey8 => Theme.of(context).textTheme.titleLarge!.color!;
  Color get grey9 => const Color.fromRGBO(78, 78, 78, 1);

  Color get black54 => const Color.fromRGBO(0, 0, 0, 0.533);
  Color get black => Theme.of(context).focusColor;

  static const Color teal = Color.fromRGBO(0, 150, 136, 1);
  static const Color darkBlue = Color.fromRGBO(0, 110, 197, 1.0);
  static const Color lightBlue = Color.fromRGBO(215, 233, 255, 1.0);
  static const Color blackRed = Color.fromRGBO(217, 11, 11, 1.0);
}

class BaseColorManager {
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color lightDarkGray = Color.fromRGBO(105, 105, 105, 1);
  static const Color transparentGrey = Color.fromRGBO(182, 182, 182, 0.404);
  static const Color grey1 = Color.fromRGBO(238, 238, 238, 1);

  static const Color grey2 = Color.fromRGBO(218, 218, 218, 1);
  static const Color veryLowOpacityGrey = Color.fromRGBO(68, 68, 57, 0.086);

  static const Color black = Color.fromRGBO(10, 10, 10, 1.0);
  static const Color black87 = Color.fromRGBO(0, 0, 0, 0.867);
  static const Color black54 = Color.fromRGBO(37, 37, 37, 1.0);
  static const Color black26 = Color.fromRGBO(54, 54, 54, 1.0);
  static const Color black12 = Color.fromRGBO(0, 0, 31, 0);

  static const Color grey7 = Color.fromRGBO(118, 118, 118, 1);
  static const Color grey9 = Color.fromRGBO(78, 78, 78, 1);
  static const Color greyPoint5 = Color.fromRGBO(246, 246, 246, 1.0);
  static const Color grey1Point5 = Color.fromRGBO(228, 228, 228, 1);
  static const Color grey3 = Color.fromRGBO(198, 198, 198, 1);
  static const Color grey = Color.fromRGBO(158, 158, 158, 1);
  static const Color grey6 = Color.fromRGBO(138, 138, 138, 1);
  static const Color grey8 = Color.fromRGBO(98, 98, 98, 1);

  static const Color lightBlack = Color.fromRGBO(36, 36, 36, 0.098);
  static const Color darkGray = Color.fromRGBO(40, 40, 40, 1);

  static const Color black45 = Color.fromRGBO(0, 0, 0, 0.451);
  static const Color black38 = Color.fromRGBO(0, 0, 0, 0.38);

  static const Color blue = Color(0xFF2196F3);

  static const Color yellow = Color.fromARGB(255, 252, 219, 3);

  static const Color orange = Color.fromARGB(255, 170, 115, 33);

  static const Color transparent = Colors.transparent;
}
