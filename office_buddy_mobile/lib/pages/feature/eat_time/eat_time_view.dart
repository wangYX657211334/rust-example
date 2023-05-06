import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:office_buddy/routes/routes.dart';

import '../../../util/base_widget.dart';
import 'add/eat_time_add_view.dart';

class EatTimeView extends StatelessWidget {
  const EatTimeView({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const _EatTimeList(),
    ));
  }
}

class _EatTimeList extends StatelessWidget {
  const _EatTimeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
          child: ListTile(
            leading: Icon(Icons.access_time, size: 50.0),
            title: Text('16:07'),
            subtitle: Text('昨天, 亲喂1个'),
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
                            onPressed: () {},
                          ),
                        ],
                      )),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.access_time, size: 50.0),
            title: Text('19:33'),
            subtitle: Text('昨天, 间隔3小时25分钟, 亲喂1个'),
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
                            onPressed: () {},
                          ),
                        ],
                      )),
            ),
          ),
        ),
        Card(
          color: const Color(0xfffcf6ed),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: const Text('距上次1小时30分20秒, 预计18:25左右吃奶', style: TextStyle(color: Color(0xffc4790f))),
          ),
        )
      ],
    );
  }
}
