import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_buddy/util/base_widget.dart';
import 'package:json_editor_flutter/json_editor_flutter.dart';

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
        body: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Obx(() {
                if (controller.jsonValue.value.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: const Text('加载中...'),
                  );
                } else {
                  return JsonEditor(
                    height: 800,
                    width: 350,
                    onSaved: (value) async {
                      controller.jsonValue.value =
                          const JsonEncoder.withIndent('  ').convert(value);
                      await controller.save();
                    },
                    json: controller.jsonValue.value,
                    color: Colors.white10,
                  );
                }
              }),
            ),
          ),
        ),
      ),
    );
  }
}
