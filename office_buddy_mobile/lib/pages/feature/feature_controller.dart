import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

import '../../util/base_widget.dart';
import './eat_time/eat_time_util.dart';

class FeatureController extends GetxController {
  final httpConnect = GetConnect();
  final Codec<String, String> stringToBase64 = utf8.fuse(base64);
  final token = "ffc741e757cf4bf29a3eecf60c84f7a6";
  var baseHeaders = {"": ""};

  var stopStatus = {"default": false}.obs;
  var loading = {"default": false}.obs;
  var wangZJYearsOld = "".obs;

  @override
  void onInit() {
    super.onInit();
    refreshWangZJYearsOld();
    baseHeaders = {
      "Host": stringToBase64.decode("b3BlbmFwaS5sb25nZm9yLmNvbQ=="),
      "Origin": stringToBase64.decode(
          "aHR0cHM6Ly90Y3ktYXBwb2ludG1lbnQud2FuLXByb2QubG9uZ2Zvci5jb20="),
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive",
      "Accept": "application/json, text/plain, */*",
      "User-Agent":
          "Mozilla/5.0 (iPhone; CPU iPhone OS 16_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148/qd-app-6.0.1-ios/qd-app-6.0.1-ios",
      "Accept-Language": "zh-CN,zh-Hans;q=0.9",
      "Referer": stringToBase64.decode(
          "aHR0cHM6Ly90Y3ktYXBwb2ludG1lbnQud2FuLXByb2QubG9uZ2Zvci5jb20="),
      "x-gaia-api-key": "d90257df-31f1-4a53-847b-dd92ee6ba91b",
    };
    httpConnect.baseUrl = stringToBase64
        .decode("aHR0cHM6Ly9vcGVuYXBpLmxvbmdmb3IuY29tL3RjeS1hcHBvaW50bWVudA==");
    httpConnect.onInit();
    Timer.periodic(const Duration(seconds: 1), (_) {
      refreshWangZJYearsOld();
    });
  }

  void changeStopStatus(String carNumber) async {
    loading.update(carNumber, (value) => true, ifAbsent: () => true);
    if (stopStatus.containsKey(carNumber)) {
      // 取消预约
      var record = await _getList(carNumber);
      if (record != null) {
        var id = record["id"];
        var res = await httpConnect.post("/appointment/cancel",
            {"lmToken": token, "bu_code": "C40601", "id": "$id"},
            headers: baseHeaders);
        if (res.isOk) {
          Get.snackbar("提示", "取消预约成功!");
        }
      }
    } else {
      // 预约
      var now = DateTime.now();
      var res = await httpConnect.post(
          "/appointment",
          {
            "projectId": "155088791200100650",
            "carNo": carNumber,
            "startTime":
                DateTime(now.year, now.month, now.day).millisecondsSinceEpoch,
            "endTime": DateTime(now.year, now.month, now.day, 23, 59, 59)
                .millisecondsSinceEpoch,
            "reason": 6,
            "lmToken": token,
            "bu_code": "C40601",
            "contact": "13246876436"
          },
          headers: baseHeaders);
      if (res.isOk) {
        Get.snackbar("提示", "预约成功!");
      }
    }
    refreshStopStatus(carNumber);
  }

  void refreshStopStatus(String carNumber) async {
    loading.update(carNumber, (value) => true, ifAbsent: () => true);
    if ((await _getList(carNumber)) != null) {
      stopStatus.update(carNumber, (value) => true, ifAbsent: () => true);
    } else {
      stopStatus.remove(carNumber);
    }
    loading.remove(carNumber);
  }

  Future<dynamic> _getList(String carNumber) async {
    var res = await httpConnect.get(
        "/appointment?lmToken=$token&bu_code=C40601&page=1&row=10",
        headers: baseHeaders);
    var list = (res.body as Map<String, dynamic>)["data"] as List<dynamic>;
    return list.firstWhere(
        (element) => (element as Map<String, dynamic>)["carNo"] == carNumber,
        orElse: () => null);
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
    var duration =
        _getDurationBetweenTimeOfDay(WANGZJ_BIRTHDAY_TIME, ignoreDate(DateTime.now()));
    if (duration.inMilliseconds < 0) {
      day--;
      duration = _getDurationBetweenTimeOfDay(
              WANGZJ_BIRTHDAY_TIME, DateTime(0, 0, 0, 23, 59, 59)) +
          _getDurationBetweenTimeOfDay(ignoreDate(DateTime.now()), WANGZJ_BIRTHDAY_TIME);
    }
    var interval = EatTimeUtil.getIntervalByMilliseconds(duration.inMilliseconds, true);

    String toStr(int value, String name){
      return value > 0 ? "$value$name": "";
    }

    wangZJYearsOld.value = '${toStr(year, "岁")}${toStr(month, "个月")}'
        '${toStr(day, "天")}$interval';
  }

  Duration _getDurationBetweenTimeOfDay(
      DateTime startTime, DateTime endTime) {
    return endTime.difference(startTime);
  }
  DateTime ignoreDate(DateTime dateTime){
    return DateTime(0, 0, 0, dateTime.hour, dateTime.minute, dateTime.second);
  }
}
