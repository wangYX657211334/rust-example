import 'package:get/get.dart';

import 'eat_time_history_controller.dart';


class EatTimeHistoryBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(EatTimeHistoryController());
  }
}
