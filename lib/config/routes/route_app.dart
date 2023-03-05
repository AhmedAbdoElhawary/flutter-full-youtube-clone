import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// currently, I don't use routes generator methods because there is a lot of run time errors.
/// I use normal Navigator because i don't know how to make Get.to without [appearNavigationBar].

class Go {
  final BuildContext context;
  Go(this.context);
  to(Widget page, {bool appearNavigationBar = true}) {
    return Navigator.of(context, rootNavigator: !appearNavigationBar).push(
      CupertinoPageRoute(
          builder: (context) => page, maintainState: appearNavigationBar),
    );
  }

  offAll(Widget page) => Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => page), (route) => false);

  offCurrent(Widget page, {bool materialRoute = false}) {
    return Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => page, maintainState: false));
  }

  back() => Navigator.of(context).maybePop();
}
