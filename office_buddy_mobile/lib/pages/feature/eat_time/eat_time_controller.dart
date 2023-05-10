import 'dart:async';

import 'package:get/get.dart';

import '../../../util/HttpClient.dart';
import 'model/eat_time.dart';

class EatTimeController extends GetxController {
  final HttpClient api = HttpClient();

  Timer? _timer;
  var count = 0.obs;
  var now = DateTime.now().obs;
  var data = <EatTimeModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    api.onInit();
    refreshData();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      count++;
      now.value = DateTime.now();
      // print(DateTime.now().toIso8601String());
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
      note += ", 亲喂";
    }
    if (model.breastMilk > 0) {
      note += ", 母乳${model.breastMilk}ml";
    }
    if (model.powderedMilk > 0) {
      note += ", 奶粉${model.powderedMilk}ml";
    }
    return note;
  }

  String getInterval(DateTime latestDate, DateTime modelDate, bool second) {
    String note = "";
    var interval = modelDate.millisecondsSinceEpoch - latestDate.millisecondsSinceEpoch;
    if(interval <= 0){
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
