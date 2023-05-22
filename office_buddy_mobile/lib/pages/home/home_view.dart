import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_buddy/util/base_widget.dart';

import '../feature/feature_view.dart';
import '../gpt/gpt_view.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => BaseWidget.backgroundImageWidget(Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: NavigationBar(
            backgroundColor: Colors.white10,
            onDestinationSelected: (int index) {
              controller.index = index;
            },
            selectedIndex: controller.navigationBarIndex.value,
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.home),
                label: '主页',
              ),
              NavigationDestination(
                icon: Icon(Icons.tag_faces),
                label: 'AI',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle_outlined),
                label: '个人信息',
              ),
            ],
          ),
          body: <Widget>[
            const FeatureView(),
            const MyHomePage(),
            Container(
              // color: Colors.green,
              alignment: Alignment.center,
              child: const Text('正在建设中!'),
            ),
          ][controller.navigationBarIndex.value],
        )));
  }
}
