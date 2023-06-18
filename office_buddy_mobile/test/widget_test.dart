// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  var now = DateTime.now();
  print({
    "projectId": "155088791200100650",
    "carNo": "辽AF39Q1",
    "startTime":
    DateTime(now.year, now.month, now.day).millisecondsSinceEpoch,
    "endTime": DateTime(now.year, now.month, now.day, 23, 59, 59)
        .millisecondsSinceEpoch,
    "reason": 6,
    "lmToken": "ffc741e757cf4bf29a3eecf60c84f7a6",
    "bu_code": "C40601",
    "contact": "13246876436"
  });

}
