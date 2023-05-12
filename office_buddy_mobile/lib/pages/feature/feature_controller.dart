import 'package:get/get.dart';

class FeatureController extends GetxController {
  final httpConnect = GetConnect();
  final token = "ffc741e757cf4bf29a3eecf60c84f7a6";
  final baseHeaders = {
    "Host": "openapi.longfor.com",
    "Origin": "https://tcy-appointment.wan-prod.longfor.com",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive",
    "Accept": "application/json, text/plain, */*",
    "User-Agent":
        "Mozilla/5.0 (iPhone; CPU iPhone OS 16_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148/qd-app-6.0.1-ios/qd-app-6.0.1-ios",
    "Accept-Language": "zh-CN,zh-Hans;q=0.9",
    "Referer": "https://tcy-appointment.wan-prod.longfor.com/",
    "x-gaia-api-key": "d90257df-31f1-4a53-847b-dd92ee6ba91b",
  };

  var stopStatus = false.obs;
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    httpConnect.baseUrl = "https://openapi.longfor.com/tcy-appointment";
    httpConnect.onInit();
  }

  void changeStopStatus() async {
    loading.value = true;
    if (stopStatus.value) {
      // 取消预约
      var list = await _getList();
      if(list.isNotEmpty){
        var id = list[0]["id"];
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
        "carNo": "辽A99C73",
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
    refreshStopStatus();
  }

  void refreshStopStatus() async {
    loading.value = true;
    stopStatus.value = (await _getList()).isNotEmpty;
    loading.value = false;
  }

  Future<List<dynamic>> _getList() async {
    var res = await httpConnect.get("/appointment?lmToken=$token&bu_code=C40601&page=1&row=10", headers: baseHeaders);
    var list = (res.body as Map<String, dynamic>)["data"] as List<dynamic>;
    return list;
  }
}
