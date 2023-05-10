import 'package:get/get.dart';

class HttpClient extends GetConnect{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    baseUrl = "https://nas.wangyuxin.tech:9400/office-buddy";
  }
}