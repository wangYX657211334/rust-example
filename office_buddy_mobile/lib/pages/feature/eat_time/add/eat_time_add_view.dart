import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_buddy/util/base_widget.dart';

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
            ListTile(
              title: Text('亲喂'),
              trailing: Obx(() => CupertinoSwitch(
                    // This bool value toggles the switch.
                    value: controller.motherFeeding.value,
                    activeColor: CupertinoColors.activeBlue,
                    onChanged: (value) {
                      controller.motherFeeding.value = value;
                    },
                  )),
            ),
            ListTile(
                title: Text('母乳'),
                trailing: Obx(() => Text('${controller.breastMilk.value}ml')),
                onTap: () => showSelect(
                    context: context,
                    initialItem:
                        controller.getValueIndex(controller.breastMilk.value),
                    children: controller.milkList
                        .map((e) => Center(child: Text("${e}ml")))
                        .toList(),
                    onChanged: (int selectedItem) {
                      controller.breastMilk.value =
                          controller.milkList[selectedItem];
                    })),
            ListTile(
                title: Text('奶粉'),
                trailing: Obx(() => Text('${controller.powderedMilk.value}ml')),
                onTap: () => showSelect(
                    context: context,
                    initialItem:
                        controller.getValueIndex(controller.powderedMilk.value),
                    children: controller.milkList
                        .map((e) => Center(child: Text("${e}ml")))
                        .toList(),
                    onChanged: (int selectedItem) {
                      controller.powderedMilk.value =
                          controller.milkList[selectedItem];
                    })),
            const Divider(
              indent: 50,
              endIndent: 50,
            ),
            Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: controller.otherFood.length,
                      itemBuilder: (context, index) {
                        // var food = controller.otherFood[index];
                        return swipeToDelete(
                            child: ListTile(
                                title: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        controller.otherFoodNameList[controller
                                                .otherFood[index]["name"] ?? 0],
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () => showSelect(
                                    context: context,
                                    initialItem: controller.otherFood[index]["name"] ?? 0,
                                    children: controller.otherFoodNameList
                                          .map((n) => Center(child: Text(n)))
                                          .toList(),
                                    onChanged: (value) {
                                      var food = controller.otherFood[index];
                                      food["name"] = value;
                                      controller.otherFood[index] = food;
                                    })),
                            deleteHandler: () =>
                                controller.otherFood.removeAt(index));
                      },
                    ))),
            const Divider(
              indent: 50,
              endIndent: 50,
            ),
            ListTile(
              title: const Text('添加辅食', textAlign: TextAlign.center),
              onTap: () => {
                controller.otherFood.add({"name": 0, "size": 0})
              },
            ),
            const Divider(),
          ],
        )));
  }
}
