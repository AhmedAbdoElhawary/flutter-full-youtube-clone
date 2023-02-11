class CountsReformat {
  static String basicViewsFormat(String views) {
    int length = views.length;
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
    return "$viewsNewFormat views";
  }

  static String _reformat(String views, int count, String char) {
    return count == 1
        ? ("${views[0]}.${views[1]}$char")
        : count == 2
            ? ("${views[0]}${views[1]}.${views[2]}$char")
            : ("${views[0]}${views[1]}${views[2]}$char");
  }

  static String videoDurationFormat(String duration) {
    int unUsefulLastCharIndex = duration.indexOf("T");
    int hourCharIndex = duration.indexOf("H");
    int minuteCharIndex = duration.indexOf("M");
    int secondLatterIndex = duration.indexOf("S");

    String durationReformat = "";
    if (hourCharIndex != -1) {
      durationReformat =
          _timeDuration(duration, unUsefulLastCharIndex, hourCharIndex);
    }
    if (minuteCharIndex != -1) {
      durationReformat +=
          _timeDuration(duration, hourCharIndex, minuteCharIndex);
    }

    String secondFormat =
        _timeDuration(duration, minuteCharIndex, secondLatterIndex);
    durationReformat += secondFormat.replaceAll(":", "");

    return durationReformat;
  }

  static String _timeDuration(String duration, int start, int end) {
    String count = duration.substring(start, end);
    count = count.length == 1 ? "0$count" : count;
    return "$count:";
  }
}
