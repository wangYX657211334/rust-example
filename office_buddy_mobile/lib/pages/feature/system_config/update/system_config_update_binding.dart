import 'package:get/get.dart';

import 'system_config_update_controller.dart';

class SystemConfigUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SystemConfigUpdateController());
  }
}
