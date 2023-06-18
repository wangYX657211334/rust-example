import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../util/base_widget.dart';
import '../eat_time_util.dart';
import '../model/eat_time.dart';
import 'eat_time_history_controller.dart';

class EatTimeHistory extends GetView<EatTimeHistoryController> {
  const EatTimeHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget.backgroundImageWidget(Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: const Text('王知槿吃奶时间历史查询'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('日期'),
            trailing: Obx(() => Text(controller.dateToString())),
            onTap: () async {
              controller.conditionDate.value = (await showDatePicker(
                context: context,
                initialDate: controller.conditionDate.value,
                firstDate: DateTime.utc(2022, 12, 26),
                lastDate: DateTime.utc(9999, 1, 1),
              ))!;
              controller.refreshData();
            },
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.data.length,
                  itemBuilder: (context, index) {
                    return _EatTimeDetail(index, controller.data);
                  },
                )),
          ),
        ],
      ),
    ));
  }
}

class _EatTimeDetail extends StatelessWidget {
  const _EatTimeDetail(this.index, this.modelList, {super.key});

  final int index;
  final List<EatTimeModel> modelList;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.access_time, size: 50.0),
        title: Text(modelList[index].time.substring(11, 16)),
        subtitle: Text(modelList[index].note),
      ),
    );
  }
}
