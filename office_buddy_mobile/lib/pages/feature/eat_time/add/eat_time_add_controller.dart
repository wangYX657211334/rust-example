import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../util/HttpClient.dart';
import '../model/eat_time.dart';

class EatTimeAddController extends GetxController {
  final HttpClient api = HttpClient();
  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  final DateFormat timeFormatter = DateFormat('HH:mm');

  List<int> values = [0, 170, 180, 190];

  var date = DateTime.now().obs;
  var time = TimeOfDay.now().obs;
  var motherFeeding = 1.obs;
  var breastMilk = 0.obs;
  var powderedMilk = 0.obs;
  var managementId = 1.obs;

  @override
  void onInit() async {
    super.onInit();
    api.onInit();

  }

  void save() async {
    var model = EatTimeModel(
        id: 0,
        motherFeeding: motherFeeding.value,
        breastMilk: breastMilk.value,
        powderedMilk: powderedMilk.value,
        managementId: managementId.value,
        time: "${dateToString()}T${timeToString()}:00+08:00");

    var result = await api.post("/home/time", model.toJson());
    if(result.isOk){
      Get.snackbar('提示', '保存成功!');
      // Timer(Duration(milliseconds: 100), ()=> Get.back());
    }else{
      Get.snackbar('提示', '保存失败!');
    }
  }

  String dateToString() => dateFormatter.format(date.value);

  String timeToString() {
    String addLeadingZeroIfNeeded(int value) {
      if (value < 10) {
        return '0$value';
      }
      return value.toString();
    }

    return "${addLeadingZeroIfNeeded(time.value.hour)}:${addLeadingZeroIfNeeded(time.value.minute)}";
  }
}
