import 'package:get/get.dart';

import '../feature/feature_controller.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  // @override
  // List<Bind> dependencies() {
  //   return [
  //     Bind.lazyPut(() => HomeController()),
  //   ];
  // }
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(FeatureController());
  }
}
