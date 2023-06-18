import 'model/eat_time.dart';

class EatTimeUtil {

  static String getInterval(
      DateTime latestDate, DateTime modelDate, bool second) {
    return getIntervalByMilliseconds(
        modelDate.millisecondsSinceEpoch - latestDate.millisecondsSinceEpoch,
        second);
  }

  static String getIntervalByMilliseconds(int interval, bool second) {
    String note = "";
    if (interval <= 0) {
      return "0秒";
    }
    if (interval / (60 * 60 * 1000) > 1) {
      note += "${interval ~/ (60 * 60 * 1000)}小时";
      interval = interval % (60 * 60 * 1000);
    }
    if (interval / (60 * 1000) > 1) {
      note += "${interval ~/ (60 * 1000)}分钟";
      interval = interval % (60 * 1000);
    }
    if (interval / (1000) > 1 && second) {
      note += "${interval ~/ 1000}秒";
      interval = interval % (1000);
    }
    return note;
  }
}
