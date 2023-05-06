import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:office_buddy/routes/routes.dart';

// import 'pages/home/eattime/eat_time_view.dart';
import 'pages/feature/feature_view.dart';

void main() {
  runApp(
      GetMaterialApp(
        theme: ThemeData(
            colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
        initialRoute: AppRoutes.initial,
        getPages: AppRoutes.routes
      )
  );
}
