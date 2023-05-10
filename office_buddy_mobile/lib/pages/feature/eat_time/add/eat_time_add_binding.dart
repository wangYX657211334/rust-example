import 'package:get/get.dart';

import 'eat_time_add_controller.dart';

class EatTimeAddBinding extends Bindings {
  // @override
  // List<Bind> dependencies() {
  //   return [
  //     Bind.lazyPut(() => EatTimeAddController()),
  //   ];
  // }
  @override
  void dependencies() {
    Get.put(EatTimeAddController());
  }
}
