import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_buddy/util/base_widget.dart';

import 'system_config_update_controller.dart';

class SystemConfigUpdateView extends GetView<SystemConfigUpdateController> {
  const SystemConfigUpdateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BaseWidget.backgroundImageWidget(
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.white10,
            title: Text(Get.arguments["name"]),
          ),
          body: Text("test")),
    );
  }
}
