import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';

class FeatureView extends StatelessWidget {
  const FeatureView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.add),
        //     onPressed: () {
        //       Get.snackbar('title', 'message');
        //     },
        //   )
        // ],
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
              leading: Icon(Icons.date_range, size: 50.0),
              title: Text('王知槿吃奶时间记录'),
              subtitle: Text('记录吃奶间隔时间, 以免重复'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Get.toNamed(AppRoutes.eatTime);
              },
            ),
          ),
          Card(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.history, size: 50.0),
              title: Text('王知槿吃奶时间历史查询'),
              subtitle: Text('可查询历史吃奶记录'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Get.toNamed(AppRoutes.eatTimeHistory);
              },
            ),
          )
        ],
      ),
    );
  }
}
