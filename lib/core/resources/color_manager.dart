import 'package:flutter/material.dart';

class ColorManager {
  /// I will need [context] when make dark mode
  BuildContext context;
  ColorManager(this.context);

  Color transparent = const Color.fromRGBO(0, 0, 0, 0);
  Color transparentWhite =
      const Color.fromRGBO(255, 255, 255, 0.23921568627450981);

  Color white = const Color.fromRGBO(255, 255, 255, 1);

  Color grey1 = const Color.fromRGBO(238, 238, 238, 1);
  Color grey1Point5 = const Color.fromRGBO(228, 228, 228, 1);

  Color grey2 = const Color.fromRGBO(218, 218, 218, 1);
  Color grey3 = const Color.fromRGBO(198, 198, 198, 1);
  Color grey4 = const Color.fromRGBO(178, 178, 178, 1);
  Color grey = const Color.fromRGBO(158, 158, 158, 1);
  Color grey6 = const Color.fromRGBO(138, 138, 138, 1);
  Color grey7 = const Color.fromRGBO(118, 118, 118, 1);
  Color grey8 = const Color.fromRGBO(98, 98, 98, 1);
  Color grey9 = const Color.fromRGBO(78, 78, 78, 1);
  Color grey10 = const Color.fromRGBO(58, 58, 58, 1);
  Color grey11 = const Color.fromRGBO(38, 38, 38, 1);
  Color grey12 = const Color.fromRGBO(18, 18, 18, 1);

  Color lightBlack = const Color.fromRGBO(36, 36, 36, 0.098);
  Color black12 = const Color.fromRGBO(0, 0, 31, 0);
  Color black26 = const Color.fromRGBO(0, 0, 0, 0.259);
  Color black38 = const Color.fromRGBO(0, 0, 0, 0.38);
  Color black45 = const Color.fromRGBO(0, 0, 0, 0.451);
  Color black54 = const Color.fromRGBO(0, 0, 0, 0.533);
  Color black87 = const Color.fromRGBO(0, 0, 0, 0.867);
  Color black = const Color.fromARGB(255, 0, 0, 0);

  static const Color teal = Color.fromRGBO(0, 150, 136, 1);
  static const Color blue = Color.fromRGBO(33, 150, 243, 1);
  static const Color darkBlue = Color.fromRGBO(0, 103, 187, 1.0);
  static const Color green = Color.fromRGBO(76, 175, 80, 1);
  static const Color purple = Color.fromRGBO(160, 4, 238, 1);
  static const Color lightPurple = Color.fromRGBO(137, 147, 255, 0.369);
  static const Color lightBlue = Color.fromRGBO(215, 233, 255, 1.0);
  static const Color redAccent = Color.fromRGBO(255, 82, 82, 1);
  static const Color red = Color.fromRGBO(253, 0, 24, 1.0);
  static const Color blackRed = Color.fromRGBO(211, 11, 11, 1.0);
  static const Color yellow = Color.fromRGBO(252, 219, 3, 1);
  static const Color lightYellow = Color.fromRGBO(255, 240, 27, 0.859);
  static const Color orange = Color.fromRGBO(170, 115, 33, 1);
}

class BaseColorManager {
  static const Color white = Color(0xffFFFFFF);
  static const Color lightDarkGray = Color(0xff696969);
  static const Color grey = Color(0xff9E9E9E);
  static const Color transparentGrey = Color(0xd79f9f9f);
  static const Color lightGrey = Color(0xffb9b9b9);
  static const Color veryLightGrey = Color.fromARGB(255, 231, 231, 231);

  static const Color lowOpacityGrey = Color(0x2A3E3E2F);
  static const Color veryLowOpacityGrey = Color(0x16444439);
  static const Color veryLowOpacityGrey2 = Color.fromARGB(20, 119, 119, 109);

  static const Color black = Color(0xff000000);
  static const Color black87 = Color(0xdd000000);
  static const Color black54 = Color(0x8a000000);
  static const Color black26 = Color(0x42000000);
  static const Color black12 = Color(0x0000001F);
  static const Color shimmerDarkGrey = Color(0xFFAFAFAF);

  static const Color lightBlack = Color(0x19242424);
  static const Color darkGray = Color(0xff282828);

  static const Color black45 = Colors.black45;
  static const Color black38 = Colors.black38;

  static const Color teal = Color(0xFF009688);
  static const Color blue = Color(0xFF2196F3);
  static const Color green = Colors.green;

  static const Color purple = Color.fromARGB(255, 160, 4, 238);
  static const Color lightPurple = Color.fromARGB(94, 137, 147, 255);

  static const Color lightBlue = Color(0xFF93C6F8);

  static const Color redAccent = Colors.redAccent;
  static const Color red = Color(0xffe61f34);
  static const Color blackRed = Color.fromARGB(255, 182, 14, 14);
  static const Color yellow = Color.fromARGB(255, 252, 219, 3);
  static const Color lightYellow = Color.fromARGB(219, 255, 240, 27);

  static const Color orange = Color.fromARGB(255, 170, 115, 33);

  static const Color transparent = Colors.transparent;
}
