
import 'package:flutter/foundation.dart';

class CountsReformat {
  static String basicCountFormat(String views) {
    int length = views.length;
    if (length == 0) return "";
    String viewsNewFormat = length > 3
        ? length > 4
            ? length > 5
                ? length > 6
                    ? length > 7
                        ? length > 8
                            ? length > 9
                                ? length > 10
                                    ? length > 11
                                        ? _reformat(views, 3, "B")
                                        : _reformat(views, 2, "B")
                                    : _reformat(views, 1, "B")
                                : _reformat(views, 3, "M")
                            : _reformat(views, 2, "M")
                        : _reformat(views, 1, "M")
                    : _reformat(views, 3, "K")
                : _reformat(views, 2, "K")
            : _reformat(views, 1, "K")
        : views;
    return viewsNewFormat;
  }

  static String _reformat(String views, int count, String char) {
    return count == 1
        ? ("${views[0]}.${views[1]}$char")
        : count == 2
            ? ("${views[0]}${views[1]}.${views[2]}$char")
            : ("${views[0]}${views[1]}${views[2]}$char");
  }

  static String videoDurationFormat(String durationString) {
    try {
      RegExp regExp = RegExp(r"""
P(?:(\d+)D)?T(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?""");
      Iterable<Match> matches = regExp.allMatches(durationString);
      Match match = matches.first;

      int days = int.parse(match.group(1) ?? '0');
      int hours = int.parse(match.group(2) ?? '0');
      int minutes = int.parse(match.group(3) ?? '0');
      int seconds = int.parse(match.group(4) ?? '0');

      Duration duration = Duration(
          days: days, hours: hours, minutes: minutes, seconds: seconds);

      int hoursInt = duration.inHours;
      int minutesInt = duration.inMinutes.remainder(60);
      int secondsInt = duration.inSeconds.remainder(60);

      String hoursStr = hoursInt.toString().padLeft(2, '0');
      String minutesStr = minutesInt.toString().padLeft(2, '0');
      String secondsStr = secondsInt.toString().padLeft(2, '0');

      return hoursInt > 0
          ? '$hoursStr:$minutesStr:$secondsStr'
          : '$minutesStr:$secondsStr';
    } catch (e) {
      if (kDebugMode) {
        print('============-----------------> $e');
      }
      return "";
    }
  }
}
