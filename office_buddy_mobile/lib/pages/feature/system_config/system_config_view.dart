import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:office_buddy/routes/routes.dart';
import 'package:office_buddy/util/base_widget.dart';

import 'system_config_controller.dart';

class SystemConfigView extends GetView<SystemConfigController> {
  const SystemConfigView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: const Text('系统配置'),
      ),
      body: CupertinoListSection.insetGrouped(
        header: const Text('元数据配置'),
        backgroundColor: Colors.transparent,
        children: <Widget>[
          CupertinoListTile.notched(
            leading: const Icon(Icons.filter_list_sharp),
            title: const Text('奶量'),
            onTap: () {
              Get.toNamed(AppRoutes.systemConfigUpdate, arguments: {
                "code": "MilkSize",
                "name": "奶量"
              });
            },
          ),
          CupertinoListTile.notched(
            leading: const Icon(Icons.flatware_sharp),
            title: const Text('辅食'),
            onTap: () {
              Get.toNamed(AppRoutes.systemConfigUpdate, arguments: {
                "code": "OtherFoodName",
                "name": "辅食"
              });
            },
          ),
        ],
      ),
    );
  }
}
