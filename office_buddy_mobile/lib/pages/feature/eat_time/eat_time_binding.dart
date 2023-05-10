import 'package:get/get.dart';

import '../../home/home_controller.dart';
import 'eat_time_controller.dart';

class EatTimeBinding extends Bindings {
  // @override
  // List<Bind> dependencies() {
  //   return [
  //     Bind.lazyPut(() => EatTimeController()),
  //   ];
  // }
  @override
  void dependencies() {
    Get.put(EatTimeController());
  }
}
