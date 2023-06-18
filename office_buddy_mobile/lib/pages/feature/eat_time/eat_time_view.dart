import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:office_buddy/pages/feature/eat_time/eat_time_controller.dart';
import 'package:office_buddy/routes/routes.dart';

import '../../../util/base_widget.dart';
import 'model/eat_time.dart';

class EatTimeView extends GetView<EatTimeController> {
  const EatTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget.backgroundImageWidget(
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  var result = await Get.toNamed(AppRoutes.eatTimeAdd);
                  if (result == REFRESH_FLAG) {
                    controller.refreshData();
                  }
                },
              )
            ],
            backgroundColor: Colors.white10,
            title: const Text('王知槿吃奶时间记录'),
          ),
          body: Obx(() => Column(
                children: [
                  Expanded(
                      child: BaseWidget.pullUpRefresh(
                          ListView.builder(
                            itemCount: controller.data.length,
                            itemBuilder: (context, index) {
                              return _EatTimeDetail(index, controller.data, controller.delete);
                            },
                          ),
                          controller.refreshData)),
                  _Warn(controller, controller.data, controller.now.value)
                ],
              ))),
    );
  }
}

class _EatTimeDetail extends StatelessWidget {
  const _EatTimeDetail(this.index, this.modelList, this.delete,
      {super.key});

  final int index;
  final List<EatTimeModel> modelList;
  final void Function(String id) delete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.access_time, size: 50.0),
        title: Text(modelList[index].time.substring(11, 16)),
        subtitle: Text(modelList[index].note),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => showDeleteDialog(
              context: context, onPressed: () => delete(modelList[index].id)),
        ),
      ),
    );
  }
}

class _Warn extends StatelessWidget {
  const _Warn(this.c, this.data, this.now);

  final EatTimeController c;
  final List<EatTimeModel> data;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    var interval = "0秒";
    var future = "00:00";
    if (data.isNotEmpty) {
      interval = c.getInterval(DateTime.parse(data.last.time), now, true);
      var futureTime =
          DateTime.parse(data.last.time).add(const Duration(hours: 3));
      future = "${futureTime.hour}:${futureTime.minute}";
    }
    return Card(
      color: const Color(0xfffcf6ed),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text('距上次$interval, 预计$future左右吃奶',
            style: const TextStyle(color: Color(0xffc4790f))),
      ),
    );
  }
}
