import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

const int REFRESH_FLAG = 0;
final DateTime WANGZJ_BIRTHDAY = DateTime(2022, 12, 26, 13, 38);
final DateTime WANGZJ_BIRTHDAY_TIME = DateTime(0, 0, 0, 13, 38, 00);

class BaseWidget {
  static const BoxDecoration backgroundImage = BoxDecoration(
    color: Colors.white,
    image: DecorationImage(
      fit: BoxFit.cover,
      colorFilter: ColorFilter.linearToSrgbGamma(),
      image: AssetImage("assets/image/wangzj.jpg"),
    ),
  );

  // 背景
  static Widget backgroundImageWidget(Widget widget) {
    return Container(
      decoration: BaseWidget.backgroundImage,
      child: widget,
    );
  }

  // 上拉刷新
  static Widget pullUpRefresh(
      Widget widget, Future<void> Function() onRefresh) {
    return RefreshIndicator(onRefresh: onRefresh, child: widget);
  }
}

/// 选择器
Future<void> showSelect(
    {required BuildContext context,
    required List<Widget> children,
    required int initialItem,
    required ValueChanged<int> onChanged}) async {
  return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            // The Bottom margin is provided to align the popup above the system navigation bar.
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            // Provide a background color for the popup.
            color: CupertinoColors.systemBackground.resolveFrom(context),
            // Use a SafeArea widget to avoid system overlaps.
            child: SafeArea(
              top: false,
              child: CupertinoPicker(
                magnification: 1.22,
                squeeze: 1.2,
                useMagnifier: true,
                itemExtent: 32.0,
                scrollController:
                    FixedExtentScrollController(initialItem: initialItem),
                // This is called when selected item is changed.
                onSelectedItemChanged: onChanged,
                children: children,
              ),
            ),
          ));
}

/// 选择器
typedef MultipleValueChanged = void Function(String key, int index);
Future<void> showMultipleSelect(
    {required BuildContext context,
      required Map<String, List<Widget>> children,
      required Map<String, int> initialItem,
      required MultipleValueChanged onChanged}) async {
  List<Widget> col = [];
  children.forEach((key, value) {
    col.add(Expanded(child: CupertinoPicker(
      magnification: 1.22,
      squeeze: 1.2,
      useMagnifier: true,
      itemExtent: 32.0,
      scrollController: FixedExtentScrollController(initialItem: initialItem[key] ?? 0),
      // This is called when selected item is changed.
      onSelectedItemChanged: (int index) => onChanged(key, index),
      children: value,
    )));
  });
  return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: Row(children: col)
        ),
      ));
}

/// 滑动删除
typedef DeleteHandler = void Function();
swipeToDelete({
  required Widget child,
  required DeleteHandler deleteHandler
}){
  return Dismissible(
    key: UniqueKey(),
    direction: DismissDirection.endToStart,
    onDismissed: (direction) {
      deleteHandler();
    },
    background: Container(
      color: Colors.red,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
    ),
    child: child
  );
}

/// 删除确认框
Future<void> showDeleteDialog(
    {required BuildContext context, required VoidCallback onPressed}) async {
  showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
            title: const Text('提示'),
            message: const Text('是否要删除当前项？'),
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () {
                  onPressed();
                  Get.back();
                },
                isDefaultAction: true,
                child: const Text('删除'),
              ),
              CupertinoActionSheetAction(
                onPressed: () => Get.back(),
                isDestructiveAction: true,
                child: const Text('暂时不删除'),
              ),
            ],
          ));
}
