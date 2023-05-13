import 'dart:async';

import 'package:get/get.dart';

import '../../../util/HttpClient.dart';
import 'eat_time_util.dart';
import 'model/eat_time.dart';

class EatTimeController extends GetxController {
  final HttpClient api = HttpClient();

  Timer? _timer;
  var now = DateTime.now().obs;
  var data = <EatTimeModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    api.onInit();
    refreshData();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      now.value = DateTime.now();
    });
  }

  void refreshData() async {
    var result = await api.get("/home/time/1",
        decoder: (val) => (val as List<dynamic>)
            .map((item) => EatTimeModel.fromJson(item as Map<String, dynamic>))
            .toList());
    result.body?.sort((m1, m2) => m1.id - m2.id);
    data.value = result.body!;
  }

  void delete(int id) async {
    var result = await api.delete("/home/time/$id/1");
    if(result.isOk){
      Get.snackbar('提示', '删除成功!');
      refreshData();
    }
  }

  @override
  void onClose(){
    if(_timer!=null){
      _timer!.cancel();
    }
    super.onClose();
  }


  String getNote(int index, List<EatTimeModel> modelList) {
    return EatTimeUtil.getNote(index, modelList);
  }

  String getInterval(DateTime latestDate, DateTime modelDate, bool second) {
    return EatTimeUtil.getInterval(latestDate, modelDate, second);
  }
}
