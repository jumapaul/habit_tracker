import 'package:get/get.dart';

import '../controllers/select_habits_controller.dart';

class SelectHabitsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectHabitsController>(
      () => SelectHabitsController(),
    );
  }
}
