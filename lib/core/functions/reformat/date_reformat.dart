import 'package:easy_localization/easy_localization.dart';

class DateReformat {
  static String dateOfNow() => DateTime.now().toString();

  static String oneDigitFormat(DateTime? dateUtc) {
    if (dateUtc == null) return "";
    DateTime dateTime =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateUtc.toString(), true);
    DateTime dateReformat = dateTime.toLocal();

    final DateTime dateOne = DateTime.now();
    final Duration duration = dateOne.difference(dateReformat);
    return _dateOneDigitString(duration);
  }

  static String _dateOneDigitString(Duration duration) {
    int year = (duration.inDays / 256).ceil();
    int month = (duration.inDays / 30).ceil();
    int week = month * 4;
    int day = duration.inDays;
    int hour = duration.inHours;
    int minute = duration.inMinutes;
    int second = duration.inSeconds;

    return second > 60
        ? minute > 60
            ? hour > 24
                ? day > 30
                    ? week > 4
                        ? month > 12
                            ? _oneMany(year, "year")
                            : _oneMany(month, "month")
                        : _oneMany(week, "week")
                    : _oneMany(day, "day")
                : _oneMany(hour, "hour")
            : _oneMany(minute, "minute")
        : "few seconds";
  }

  static String _oneMany(int period, String text) {
    return "$period ${period <= 1 ? text : "${text}s"} ago";
  }
}
