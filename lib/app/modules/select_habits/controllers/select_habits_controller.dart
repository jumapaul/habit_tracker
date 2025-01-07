import 'package:get/get.dart';
import 'package:habit_tracker/app/data/providers/api_provider.dart';
import 'package:habit_tracker/app/data/providers/shared_preference.dart';

import '../../../data/models/habit.dart';

class SelectHabitsController extends GetxController {
  final ApiProvider apiProvider = ApiProvider();
  var habits = RxList<HabitTypes>();

  var selectedItems = <int, bool>{}.obs;
  final List<HabitTypes> selectedHabits = [];

  getHabits() async {
    var defaultHabits = await apiProvider.getDefaultHabits();
    habits.value = defaultHabits!;
  }

  void toggleSelection(int index, HabitTypes habit) {
    if (selectedItems.containsKey(index)) {
      selectedItems[index] = !selectedItems[index]!;

      if (!selectedItems[index]!) {
        selectedHabits.removeWhere((item) => item.id == habit.id);
      } else {
        selectedHabits.add(habit);
      }
    } else {
      selectedItems[index] = true;
      selectedHabits.add(habit);
    }
  }

  bool isSelected(int index) {
    return selectedItems[index] ?? false;
  }

  Future<void> uploadHabits() async {
    if (selectedHabits.isNotEmpty) {
      apiProvider.uploadSelectedHabits(selectedHabits);
      saveStartDestination(true);
    } else {
      Get.showSnackbar(GetSnackBar(
        message: 'An error occurred',
        duration: Duration(seconds: 2),
      ));
    }
  }


  void saveStartDestination(bool onClicked) async {
    await SharedPreferenceHelper.saveStartDestination(onClicked);
  }

  @override
  void onInit() {
    getHabits();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
