import 'package:get/get.dart';
import 'package:office_buddy/util/HttpClient.dart';

class SystemConfigController extends GetxController {
  final HttpClient api = HttpClient();

  var configs = <Map<String, dynamic>>[].obs;

  @override
  void onInit() async {
    super.onInit();
    api.onInit();
    await refreshData();
  }

  Future refreshData() async{
    var result = await api.get("/system-config", headers: api.baseHeaders);
    configs.value = (result.body as List<dynamic>).cast<Map<String, dynamic>>();
    print(configs.value);
  }

}
