import 'package:get/get.dart';
import 'package:habit_tracker/app/modules/home/controllers/home_controller.dart';
import 'package:habit_tracker/app/modules/profile/controllers/profile_controller.dart';
import 'package:habit_tracker/app/modules/stats/controllers/stats_controller.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<StatsController>(
      () => StatsController(),
    );

    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
