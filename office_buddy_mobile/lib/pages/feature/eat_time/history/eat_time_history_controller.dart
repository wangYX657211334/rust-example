

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:office_buddy/util/HttpClient.dart';

import '../model/eat_time.dart';

class EatTimeHistoryController extends GetxController {
  final HttpClient api = HttpClient();
  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

  var conditionDate = DateTime.now().obs;
  var data = <EatTimeModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    api.onInit();
    refreshData();
  }

  void refreshData() async {
    var result = await api.get("/eat-time?date=${dateToString()}",
        headers: api.baseHeaders,
        decoder: (val) => (val as List<dynamic>)
            .map((item) => EatTimeModel.fromJson(item as Map<String, dynamic>))
            .toList());
    data.value = result.body!;
  }

  String dateToString() => dateFormatter.format(conditionDate.value);

}