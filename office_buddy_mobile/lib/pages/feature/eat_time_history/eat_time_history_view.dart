import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../util/base_widget.dart';

class EatTimeHistory extends StatelessWidget {
  const EatTimeHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget.backgroundImageWidget(Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: const Text('王知槿吃奶时间历史查询'),
      ),
      body: const _EatTimeHistory(),
    ));
  }
}

class _EatTimeHistory extends StatelessWidget {
  const _EatTimeHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('日期'),
          trailing: Text('2023-04-25'),
          onTap: () => showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.utc(2022, 12, 26),
            lastDate: DateTime.utc(9999, 1, 1),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.access_time, size: 50.0),
            title: Text('16:07'),
            subtitle: Text('昨天, 亲喂1个'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.access_time, size: 50.0),
            title: Text('19:33'),
            subtitle: Text('昨天, 间隔3小时25分钟, 亲喂1个'),
          ),
        )
      ],
    );
  }
}
