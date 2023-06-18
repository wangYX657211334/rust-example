import 'dart:collection';

import 'package:get/get.dart';

class HttpClient extends GetConnect{

  Map<String, String> baseHeaders = HashMap.fromIterables(['Authorization'], ['Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5vbXhleWhtdWpwbm1jcnVodmJ3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODY1NzIzNjIsImV4cCI6MjAwMjE0ODM2Mn0.dX-g0QYSOxemRTee0rxRooHjLJaJHAzqGweyLhm6utY']);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    baseUrl = "https://nomxeyhmujpnmcruhvbw.supabase.co/functions/v1";
  }
}