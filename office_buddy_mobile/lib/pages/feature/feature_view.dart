import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:office_buddy/util/base_widget.dart';

import '../../routes/routes.dart';
import 'feature_controller.dart';

class FeatureView extends GetView<FeatureController> {
  const FeatureView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("主页"),
        backgroundColor: Colors.white10,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Card(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(Icons.date_range, size: 50.0),
              title: const Text('王知槿吃奶时间记录'),
              subtitle: const Text('记录吃奶间隔时间, 以免重复'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Get.toNamed(AppRoutes.eatTime);
              },
            ),
          ),
          Card(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(Icons.history, size: 50.0),
              title: const Text('王知槿吃奶时间历史查询'),
              subtitle: const Text('可查询历史吃奶记录'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Get.toNamed(AppRoutes.eatTimeHistory);
              },
            ),
          ),
          _StopItem(controller, "辽BC93A2", '停车'),
          _StopItem(controller, "黑A7V1D5", '猛子专属'),
          _StopItem(controller, "辽BVC663", '代步车'),

          Card(
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Obx(()=>Text('王知槿至今有${controller.wangZJYearsOld.value}')),
            )
          ),
          // _StopItem(controller, "辽H8N786", '吉男专属'),
        ],
      ),
    );
  }
}

class _StopItem extends StatelessWidget{

  _StopItem(this.controller, this.carNumber, this.name);

  FeatureController controller;

  String carNumber;
  String name;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: ListTile(
          leading: Icon(Icons.stop_circle, size: 50.0),
          trailing: Obx(() {
            if (controller.loading.containsKey(carNumber)) {
              return Container(child: Lottie.asset('assets/lottie/141677-loader.json'));
            } else {
              return Text(controller.stopStatus.containsKey(carNumber) ? '已预约' : '未预约');
            }
          }),
          title: Row(
            children: [
              Text(name),
              Obx(
                    () => TextButton(
                    onPressed: controller.loading.containsKey(carNumber)
                        ? null
                        : ()=>controller.changeStopStatus(carNumber),
                    child:
                    Text(controller.stopStatus.containsKey(carNumber) ? '取消预约' : '预约')),
              ),
              TextButton(
                onPressed: ()=>controller.refreshStopStatus(carNumber),
                child: const Text("刷新"),
              )
            ],
          ),
        ),
      );
  }

}