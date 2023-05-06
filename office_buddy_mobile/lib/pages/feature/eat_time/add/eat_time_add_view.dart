import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_buddy/util/base_widget.dart';
import 'package:office_buddy/util/select.dart';

import '../../../../routes/routes.dart';

class EatTimeAdd extends StatelessWidget {
  const EatTimeAdd({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> values = [0, 170, 180, 190];
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
              onPressed: () {},
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
              trailing: Text('2023-04-25'),
              onTap: () => showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.utc(2022, 12, 26),
                lastDate: DateTime.utc(9999, 1, 1),
              ),
            ),
            // Divider(),
            ListTile(
              title: Text('时间'),
              trailing: Text('18:50'),
              onTap: () => showTimePicker(
                context: context,
                initialTime: const TimeOfDay(hour: 10, minute: 47),
                builder: (BuildContext context, Widget? child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: true),
                    child: child!,
                  );
                },
              ),
            ),
            // Divider(),
            ListTile(
              title: Text('亲喂'),
              trailing: CupertinoSwitch(
                // This bool value toggles the switch.
                value: true,
                activeColor: CupertinoColors.activeBlue,
                onChanged: (value) {
                  print(value);
                },
              ),
            ),
            // Divider(),
            ListTile(
                title: Text('母乳'),
                trailing: Text('0ml'),
                onTap: () => showSelect(
                    context: context,
                    children: values
                        .map((e) => Center(child: Text("${e}ml")))
                        .toList(),
                    onChanged: (int selectedItem) {
                      print(selectedItem);
                    })),
            // Divider(),
            ListTile(
                title: Text('奶粉'),
                trailing: Text('0ml'),
                onTap: () => showSelect(
                    context: context,
                    children:
                        values.map((e) => Center(child: Text("${e}ml"))).toList(),
                    onChanged: (int selectedItem) {
                      print(selectedItem);
                    })),
            const Divider(),
          ],
        )));
  }
}
