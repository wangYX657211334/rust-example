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
      body: Obx(() => BaseWidget.pullUpRefresh(
            ListView.builder(
                itemCount: controller.configs.length, // 假设有三个列表部分
                itemBuilder: (BuildContext context, int index) {
                  return _SystemConfigDetail(
                      controller.configs[index], controller.refreshData);
                }),
            controller.refreshData),
      ),
    );
  }
}

class _SystemConfigDetail extends StatelessWidget {
  const _SystemConfigDetail(this.group, this.refreshData, {super.key});

  final Map<String, dynamic> group;
  final Future Function() refreshData;

  @override
  Widget build(BuildContext context) {
    var configList = (group["configs"] as List).cast<Map<String, dynamic>>();
    return CupertinoListSection.insetGrouped(
        header: Text(group["group"]),
        backgroundColor: Colors.transparent,
        children: configList
            .map(
              (config) => CupertinoListTile.notched(
                title: Text(config["description"] ?? ""),
                onTap: () async {
                  var result = await Get.toNamed(AppRoutes.systemConfigUpdate,
                      arguments: {
                        "code": config["name"],
                        "name": config["description"]
                      });
                  if (result == REFRESH_FLAG) {
                    await refreshData();
                  }
                },
              ),
            )
            .toList());
  }
}
