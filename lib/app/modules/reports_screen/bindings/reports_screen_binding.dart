import 'package:get/get.dart';

import '../controllers/reports_screen_controller.dart';

class ReportsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportsScreenController>(
      () => ReportsScreenController(),
    );
  }
}
