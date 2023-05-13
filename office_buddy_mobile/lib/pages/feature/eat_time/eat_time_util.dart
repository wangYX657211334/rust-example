import 'model/eat_time.dart';

class EatTimeUtil {
  static String getNote(int index, List<EatTimeModel> modelList) {
    EatTimeModel model = modelList[index];
    DateTime nowDate = DateTime.now();
    DateTime modelDate = DateTime.parse(model.time);
    var note = ['', '昨天', '前天'][nowDate.day - modelDate.day];
    if (index > 0) {
      note += '${note.isEmpty ? '' : ', '}间隔';
      DateTime latestDate = DateTime.parse(modelList[index - 1].time);
      note += getInterval(latestDate, modelDate, false);
    }
    if (model.motherFeeding > 0) {
      note += "${note.isEmpty ? '' : ', '}亲喂";
    }
    if (model.breastMilk > 0) {
      note += "${note.isEmpty ? '' : ', '}母乳${model.breastMilk}ml";
    }
    if (model.powderedMilk > 0) {
      note += "${note.isEmpty ? '' : ', '}奶粉${model.powderedMilk}ml";
    }
    return note;
  }

  static String getInterval(
      DateTime latestDate, DateTime modelDate, bool second) {
    String note = "";
    var interval =
        modelDate.millisecondsSinceEpoch - latestDate.millisecondsSinceEpoch;
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
