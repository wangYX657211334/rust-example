import 'package:get/get.dart';
import 'dart:convert';

import 'package:office_buddy/util/HttpClient.dart';
import 'package:office_buddy/util/base_widget.dart';


class SystemConfigUpdateController extends GetxController {
  final HttpClient api = HttpClient();

  var jsonValue = "".obs;

  @override
  void onInit() async {
    super.onInit();
    api.onInit();
    var result = await api.get("/system-config/${Get.arguments['code']}", headers: api.baseHeaders);
    jsonValue.value = const JsonEncoder.withIndent('  ').convert({"value": result.body});
  }

  Future save() async {
    var result = await api.post("/system-config/${Get.arguments['code']}",
        const JsonDecoder().convert(jsonValue.value)["value"], headers: api.baseHeaders);
    if (result.isOk) {
      Get.back(result: REFRESH_FLAG);
      Get.snackbar('提示', '保存成功!');
    } else {
      Get.snackbar('提示', '保存失败!');
    }
  }

}
