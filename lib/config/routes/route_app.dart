import 'package:flutter/cupertino.dart';

/// currently, I don't use routes methods because there is a lot of run time errors.
/// I use normal Navigator because i don't know how to make Get.to without root.

class Go {
  final BuildContext context;
  Go(this.context);
  to(Widget page) {
    return Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  offAll(Widget page) => Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => page), (route) => false);

  back() => Navigator.of(context).maybePop();
}
