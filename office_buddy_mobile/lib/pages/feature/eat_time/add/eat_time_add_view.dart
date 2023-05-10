import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_buddy/util/base_widget.dart';
import 'package:office_buddy/util/select.dart';

import 'eat_time_add_controller.dart';

class EatTimeAdd extends GetView<EatTimeAddController> {
  const EatTimeAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget.backgroundImageWidget(Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white10,
          title: const Text('新增记录'),
          centerTitle: true,
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  textStyle: const TextStyle(color: Colors.black)),
              onPressed: controller.save,
              child: const Text('发布', style: TextStyle(color: Colors.black)),
            ),
            const Text(' ')
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Divider(),
            ListTile(
              title: Text('日期'),
              trailing: Obx(() => Text(controller.dateToString())),
              onTap: () async {
                controller.date.value = (await showDatePicker(
                  context: context,
                  initialDate: controller.date.value,
                  firstDate: DateTime.utc(2022, 12, 26),
                  lastDate: DateTime.utc(9999, 1, 1),
                ))!;
              },
            ),
            // Divider(),
            ListTile(
              title: Text('时间'),
              trailing: Obx(() => Text(controller.timeToString())),
              onTap: () async {
                controller.time.value = (await showTimePicker(
                  context: context,
                  initialTime: controller.time.value,
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: child!,
                    );
                  },
                ))!;
              },
            ),
            // Divider(),
            ListTile(
              title: Text('亲喂'),
              trailing: Obx(() => CupertinoSwitch(
                    // This bool value toggles the switch.
                    value: controller.motherFeeding > 0,
                    activeColor: CupertinoColors.activeBlue,
                    onChanged: (value) {
                      controller.motherFeeding.value = value ? 1 : 0;
                    },
                  )),
            ),
            // Divider(),
            ListTile(
                title: Text('母乳'),
                trailing: Obx(() => Text('${controller.breastMilk.value}ml')),
                onTap: () => showSelect(
                    context: context,
                    children: controller.values
                        .map((e) => Center(child: Text("${e}ml")))
                        .toList(),
                    onChanged: (int selectedItem) {
                      controller.breastMilk.value =
                          controller.values[selectedItem];
                    })),
            // Divider(),
            ListTile(
                title: Text('奶粉'),
                trailing: Obx(() => Text('${controller.powderedMilk.value}ml')),
                onTap: () => showSelect(
                    context: context,
                    children: controller.values
                        .map((e) => Center(child: Text("${e}ml")))
                        .toList(),
                    onChanged: (int selectedItem) {
                      controller.powderedMilk.value =
                          controller.values[selectedItem];
                    })),
            const Divider(),
          ],
        )));
  }
}
