import 'dart:async';

import 'package:get/get.dart';

import '../../util/HttpClient.dart';
import '../../util/base_widget.dart';
import './eat_time/eat_time_util.dart';

class FeatureController extends GetxController {
  final HttpClient api = HttpClient();

  var stopStatus = {"default": false}.obs;
  var loading = {"default": false}.obs;
  var wangZJYearsOld = "".obs;

  @override
  void onInit() {
    super.onInit();
    refreshWangZJYearsOld();
    api.onInit();
    Timer.periodic(const Duration(seconds: 1), (_) {
      refreshWangZJYearsOld();
    });
  }

  void changeStopStatus(String carNumber) async {
    loading.update(carNumber, (value) => true, ifAbsent: () => true);
    if (stopStatus.containsKey(carNumber)) {
      // 取消预约
      var res =
          await api.delete("/appointment/$carNumber", headers: api.baseHeaders);
      if (res.isOk) {
        Get.snackbar("提示", "取消预约成功!");
      }
    } else {
      // 预约
      var res = await api.post("/appointment/$carNumber", null,
          headers: api.baseHeaders);
      if (res.isOk) {
        Get.snackbar("提示", "预约成功!");
      }
    }
    refreshStopStatus(carNumber);
  }

  void refreshStopStatus(String carNumber) async {
    loading.update(carNumber, (value) => true, ifAbsent: () => true);
    if ((await isAppointment(carNumber))) {
      stopStatus.update(carNumber, (value) => true, ifAbsent: () => true);
    } else {
      stopStatus.remove(carNumber);
    }
    loading.remove(carNumber);
  }

  Future<bool> isAppointment(String carNumber) async {
    var res =
        await api.get("/appointment/$carNumber", headers: api.baseHeaders);
    return res.statusCode == 200;
  }

  void refreshWangZJYearsOld() {
    var now = DateTime.now();
    var year = now.year - WANGZJ_BIRTHDAY.year;
    var month = 0;
    var day = 0;
    if (now.month < WANGZJ_BIRTHDAY.month) {
      year--;
      month = 12 - WANGZJ_BIRTHDAY.month + now.month;
    } else {
      month = now.month - WANGZJ_BIRTHDAY.month;
    }
    if (now.day < WANGZJ_BIRTHDAY.day) {
      month--;
      day = 30 - WANGZJ_BIRTHDAY.day + now.day;
    } else {
      day = now.day - WANGZJ_BIRTHDAY.day;
    }
    var duration = _getDurationBetweenTimeOfDay(
        WANGZJ_BIRTHDAY_TIME, ignoreDate(DateTime.now()));
    if (duration.inMilliseconds < 0) {
      day--;
      duration = _getDurationBetweenTimeOfDay(
              WANGZJ_BIRTHDAY_TIME, DateTime(0, 0, 0, 23, 59, 59)) +
          _getDurationBetweenTimeOfDay(
              ignoreDate(DateTime.now()), WANGZJ_BIRTHDAY_TIME);
    }
    var interval =
        EatTimeUtil.getIntervalByMilliseconds(duration.inMilliseconds, true);

    String toStr(int value, String name) {
      return value > 0 ? "$value$name" : "";
    }

    wangZJYearsOld.value = '${toStr(year, "岁")}${toStr(month, "个月")}'
        '${toStr(day, "天")}$interval';
  }

  Duration _getDurationBetweenTimeOfDay(DateTime startTime, DateTime endTime) {
    return endTime.difference(startTime);
  }

  DateTime ignoreDate(DateTime dateTime) {
    return DateTime(0, 0, 0, dateTime.hour, dateTime.minute, dateTime.second);
  }
}
