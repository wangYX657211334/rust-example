import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

const int refreshFlag = 0;

class BaseWidget {

  static const BoxDecoration backgroundImage = BoxDecoration(
    color: Colors.white,
    image: DecorationImage(
      fit: BoxFit.cover,
      colorFilter: ColorFilter.linearToSrgbGamma(),
      image: NetworkImage(
          "https://gitee.com/ITWangYX/static/raw/master/office-buddy/wangzj.jpg"),
    ),
  );

  static Widget backgroundImageWidget(Widget widget) {
    return Container(
      decoration: BaseWidget.backgroundImage,
      child: widget,
    );
  }
}

/// 选择器
Future<void> showSelect(
    {required BuildContext context, required List<Widget> children, required int initialItem, required ValueChanged<int> onChanged}) async {
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
            scrollController: FixedExtentScrollController(initialItem: initialItem),
            // This is called when selected item is changed.
            onSelectedItemChanged: onChanged,
            children: children,
          ),
        ),
      )
  );
}

/// 删除确认框
Future<void> showDeleteDialog({required BuildContext context, required VoidCallback onPressed}) async {
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