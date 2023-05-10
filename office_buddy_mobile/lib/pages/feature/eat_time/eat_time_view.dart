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
    // final EatTimeController c = Get.find();
    return BaseWidget.backgroundImageWidget(Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Get.toNamed(AppRoutes.eatTimeAdd);
              },
            )
          ],
          backgroundColor: Colors.white10,
          title: const Text('王知槿吃奶时间记录'),
        ),
        body: Obx(() => ListView.builder(
            itemCount: controller.data.length + 1,
            itemBuilder: (context, index) {
              if (index == controller.data.length) {
                return _Warn(controller);
              }
              return _EatTimeDetail(index, controller.data, controller.getNote,
                controller.delete);
            },
          ))),
        );
  }
}

class _EatTimeDetail extends StatelessWidget {
  const _EatTimeDetail(this.index, this.modelList, this.getNote, this.delete, {super.key});

  final int index;
  final List<EatTimeModel> modelList;
  final String Function(int index, List<EatTimeModel> modelList) getNote;
  final void Function(int id) delete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.access_time, size: 50.0),
        title: Text(modelList[index].time.substring(11, 16)),
        subtitle: Text(getNote(index, modelList)),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    content: Text(
                      '确定删除?',
                      style: TextStyle(color: Color(0xFFFF0000)),
                    ),
                    actions: [
                      TextButton(
                          child: Text('取消'),
                          onPressed: () => Navigator.pop(context)),
                      TextButton(
                        child: Text('确定'),
                        onPressed: () {
                          delete(modelList[index].id);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )),
        ),
      ),
    );
  }
}

class _Warn extends StatelessWidget {
  const _Warn(this.c);
  final EatTimeController c;

  @override
  Widget build(BuildContext context) {
    var interval = "0秒";
    var future = "00:00";
    if(c.data.isNotEmpty){
      interval = c.getInterval(DateTime.parse(c.data.last.time), c.now.value, true);
      var futureTime = DateTime.parse(c.data.last.time).add(const Duration(hours: 3))
          // +8时区
          .add(const Duration(hours: 8));
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