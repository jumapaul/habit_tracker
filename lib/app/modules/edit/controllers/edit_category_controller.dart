import 'package:get/get.dart';

import '../../../data/models/habit.dart';
import '../../../data/providers/api_provider.dart';

class EditCategoryController extends GetxController {
  final ApiProvider apiProvider = ApiProvider();
  var selectedItems = <int, bool>{}.obs;
  final List<HabitTypes> selectedHabits = [];
  var habits = RxList<HabitTypes>();

  getHabits() async {
    var defaultHabits = await apiProvider.getDefaultHabits();
    habits.value = defaultHabits!;
  }

  void updateCategory() async {
    await apiProvider.updateSelectedCategory(selectedHabits);
  }

  void toggleSelection(int index, HabitTypes habit) {
    if (selectedItems.containsKey(index)) {
      selectedItems[index] = !selectedItems[index]!;

      if (!selectedItems[index]!) {
        selectedHabits.removeWhere((item) => item.id == habit.id);
      } else {
        //Check if item already exists
        if (!selectedHabits.any((item) => item.id == habit.id)) {
          selectedHabits.add(habit);
        }
      }
    } else {
      selectedItems[index] = true;
      if (!selectedHabits.any((item) => item.id == habit.id)) {
        selectedHabits.add(habit);
      }
    }
  }

  bool isSelected(int index) {
    return selectedItems[index] ?? false;
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
