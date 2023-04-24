import 'package:flutter/material.dart';

class FeatureList extends StatelessWidget {
  const FeatureList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
          child: ListTile(
            leading: Icon(Icons.date_range, size: 50.0),
            title: Text('王知槿吃奶时间记录'),
            subtitle: Text('记录吃奶间隔时间, 以免重复'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {

            },
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.history, size: 50.0),
            title: Text('王知槿吃奶时间历史查询'),
            subtitle: Text('可查询历史吃奶记录'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {

            },
          ),
        )
      ],
    );
  }
}
