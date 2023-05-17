import 'dart:convert';

import 'package:get/get.dart';

class FeatureController extends GetxController {
  final httpConnect = GetConnect();
  final Codec<String, String> stringToBase64 = utf8.fuse(base64);
  final token = "ffc741e757cf4bf29a3eecf60c84f7a6";
  var baseHeaders = {"": ""};

  var stopStatus = {"default": false}.obs;
  var loading = {"default": false}.obs;

  @override
  void onInit() {
    super.onInit();
    baseHeaders = {
      "Host": stringToBase64.decode("b3BlbmFwaS5sb25nZm9yLmNvbQ=="),
      "Origin": stringToBase64.decode("aHR0cHM6Ly90Y3ktYXBwb2ludG1lbnQud2FuLXByb2QubG9uZ2Zvci5jb20="),
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive",
      "Accept": "application/json, text/plain, */*",
      "User-Agent":
      "Mozilla/5.0 (iPhone; CPU iPhone OS 16_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148/qd-app-6.0.1-ios/qd-app-6.0.1-ios",
      "Accept-Language": "zh-CN,zh-Hans;q=0.9",
      "Referer": stringToBase64.decode("aHR0cHM6Ly90Y3ktYXBwb2ludG1lbnQud2FuLXByb2QubG9uZ2Zvci5jb20="),
      "x-gaia-api-key": "d90257df-31f1-4a53-847b-dd92ee6ba91b",
    };
    httpConnect.baseUrl = stringToBase64.decode("aHR0cHM6Ly9vcGVuYXBpLmxvbmdmb3IuY29tL3RjeS1hcHBvaW50bWVudA==");
    httpConnect.onInit();
  }

  void changeStopStatus(String carNumber) async {
    loading.update(carNumber, (value) => true, ifAbsent: () => true);
    if (stopStatus.containsKey(carNumber)) {
      // 取消预约
      var record = await _getList(carNumber);
      if(record != null){
        var id = record["id"];
        var res = await httpConnect.post("/appointment/cancel", {
          "lmToken": token,
          "bu_code": "C40601",
          "id": "$id"
        }, headers: baseHeaders);
        if(res.isOk){
          Get.snackbar("提示", "取消预约成功!");
        }
      }
    } else {
      // 预约
      var now = DateTime.now();
      var res = await httpConnect.post("/appointment", {
        "projectId": "155088791200100650",
        "carNo": carNumber,
        "startTime": DateTime(now.year, now.month, now.day).millisecondsSinceEpoch,
        "endTime": DateTime(now.year, now.month, now.day, 23, 59, 59).millisecondsSinceEpoch,
        "reason": 6,
        "lmToken": token,
        "bu_code": "C40601",
        "contact": "13246876436"
      }, headers: baseHeaders);
      if(res.isOk){
        Get.snackbar("提示", "预约成功!");
      }
    }
    refreshStopStatus(carNumber);
  }

  void refreshStopStatus(String carNumber) async {
    loading.update(carNumber, (value) => true, ifAbsent: () => true);
    if((await _getList(carNumber)) != null){
      stopStatus.update(carNumber, (value) => true, ifAbsent: () => true);
    }else{
      stopStatus.remove(carNumber);
    }
    loading.remove(carNumber);
  }

  Future<dynamic> _getList(String carNumber) async {
    var res = await httpConnect.get("/appointment?lmToken=$token&bu_code=C40601&page=1&row=10", headers: baseHeaders);
    var list = (res.body as Map<String, dynamic>)["data"] as List<dynamic>;
    return list.firstWhere((element) => (element as Map<String, dynamic>)["carNo"] == carNumber, orElse: () => null);
  }
}
