import 'package:flutter/material.dart';

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