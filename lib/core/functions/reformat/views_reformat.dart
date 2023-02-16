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

  static String videoDurationFormat(String duration) {
    if (duration.isEmpty) return "";
    duration = duration.replaceRange(0, 2, "");
    duration = duration.replaceAll("S", "");
    duration = duration.replaceAll("M", ":");
    duration = duration.replaceAll("H", ":");
    return duration;
  }
}
