import 'package:get/get.dart';
import 'package:office_buddy/pages/feature/system_config/system_config_binding.dart';
import 'package:office_buddy/pages/feature/system_config/system_config_view.dart';
import 'package:office_buddy/pages/feature/system_config/update/system_config_update_binding.dart';
import 'package:office_buddy/pages/feature/system_config/update/system_config_update_view.dart';

import '../pages/feature/eat_time/add/eat_time_add_binding.dart';
import '../pages/feature/eat_time/add/eat_time_add_view.dart';
import '../pages/feature/eat_time/eat_time_binding.dart';
import '../pages/feature/eat_time/eat_time_view.dart';
import '../pages/feature/eat_time/history/eat_time_history_binding.dart';
import '../pages/feature/eat_time/history/eat_time_history_view.dart';
import '../pages/home/home_binding.dart';
import '../pages/home/home_view.dart';

class AppRoutes {
  static const home = "/home";
  static const eatTime = "/home/eatTime";
  static const eatTimeAdd = "/home/eatTime/add";
  static const eatTimeHistory = "/home/eatTime/history";
  static const systemConfigUpdate = "/home/systemConfig/update";

  static const initial = home;

  static final routes = [
    GetPage(
      name: initial,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: eatTime,
      page: () => const EatTimeView(),
      binding: EatTimeBinding(),
    ),
    GetPage(
      name: eatTimeAdd,
      page: () => const EatTimeAdd(),
      binding: EatTimeAddBinding(),
    ),
    GetPage(
      name: eatTimeHistory,
      page: () => const EatTimeHistory(),
      binding: EatTimeHistoryBinding(),
    ),
    GetPage(
      name: systemConfigUpdate,
      page: () => const SystemConfigUpdateView(),
      binding: SystemConfigUpdateBinding(),
    ),
  ];
}