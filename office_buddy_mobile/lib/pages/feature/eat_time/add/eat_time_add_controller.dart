import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:office_buddy/util/base_widget.dart';

import '../../../../util/HttpClient.dart';
import '../model/eat_time.dart';

class EatTimeAddController extends GetxController {
  final HttpClient api = HttpClient();
  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  final DateFormat timeFormatter = DateFormat('HH:mm');

  RxList<int> milkList = [0, 170, 180, 190].obs;
  RxList<String> otherFoodNameList = ["米粉"].obs;
  RxList<String> otherFoodSizeList = ["一半", "全部"].obs;

  var date = DateTime.now().obs;
  var time = TimeOfDay.now().obs;
  var motherFeeding = false.obs;
  var breastMilk = 0.obs;
  var powderedMilk = 0.obs;
  var otherFood = <Map<String, int>>[].obs;

  @override
  void onInit() async {
    super.onInit();
    api.onInit();
    var result = await api.get("/system-config/MilkSize,OtherFoodName,OtherFoodSize", headers: api.baseHeaders);
    if (result.isOk) {
      var milkSize = (result.body as List<dynamic>)[0];
      var otherFoodName = (result.body as List<dynamic>)[1];
      var otherFoodSize = (result.body as List<dynamic>)[2];
      if(milkSize != null) {
        milkList.value = (milkSize as List<dynamic>).map((e) => e as int).toList();
      }
      if(otherFoodName != null) {
        otherFoodNameList.value = (otherFoodName as List<dynamic>).map((e) => e as String).toList();
      }
      if(otherFoodSize != null) {
        otherFoodSizeList.value = (otherFoodSize as List<dynamic>).map((e) => e as String).toList();
      }
    }
  }

  int getValueIndex(int value) {
    int i = 0;
    for (var item in milkList) {
      if (value == item) {
        return i;
      }
      i++;
    }
    return 0;
  }

  void save() async {
    var model = EatTimeModel(
        id: '',
        motherFeeding: motherFeeding.value,
        breastMilk: breastMilk.value,
        powderedMilk: powderedMilk.value,
        time: "${dateToString()}T${timeToString()}:00",
        note: '');
    if(otherFood.isNotEmpty){
      model.other = otherFood.map((element) {
        var o = HashMap<String, String>();
        o['name'] = otherFoodNameList[element['name'] ?? 0];
        o['size'] = otherFoodSizeList[element['size'] ?? 0];
        return o;
      }).toList();
    }
    var result = await api.post("/eat-time", model.toJson(), headers: api.baseHeaders);
    if (result.isOk) {
      Get.back(result: REFRESH_FLAG);
      Get.snackbar('提示', '保存成功!');
    } else {
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
