import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/custom_theme/container_border_theme.dart';
import '../../../common/dimens/dimens.dart';
import '../../../data/models/habit.dart';
import '../../common_widget/outlined_button_widget.dart';
import '../controllers/edit_category_controller.dart';

class EditCategoryView extends GetView<EditCategoryController> {
  const EditCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      var selectedItems = controller.selectedHabits;

      print('------------Selected $selectedItems');
      var habits = controller.habits;

      return SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: habits.length == 0
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose habit',
                        style: AppTextStyles.largeHeaderStyle,
                      ),
                      AppTextStyles.mediumVerticalSpacing,
                      Text(
                        'Choose your daily habit, you can choose more than one',
                        style: AppTextStyles.largeSubHeaderStyle,
                      ),
                      AppTextStyles.mediumVerticalSpacing,
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: habits.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          var singleHabit = habits[index];

                          return _buildHabitItem(
                              singleHabit.title,
                              singleHabit.imageUrl,
                              context,
                              index,
                              singleHabit);
                        },
                      ),
                      AppTextStyles.mediumVerticalSpacing,
                      OutlinedButtonWidget(
                          onClick: () {
                            if (controller.selectedItems.isEmpty ||
                                controller.selectedItems.length < 3) {
                              Get.showSnackbar(
                                GetSnackBar(
                                  message: 'Must Select at least 3 categories',
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              controller.updateCategory();
                              // controller.uploadHabits();
                              // Get.toNamed(Routes.MAIN);
                            }
                          },
                          name: 'Update Selection')
                    ],
                  ),
                ),
        ),
      );
    }));
  }

  _buildHabitItem(String name, String image_url, BuildContext context,
      int index, HabitTypes habits) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          controller.toggleSelection(index, habits);
          print('------->Selected items ${controller.selectedHabits}');
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: controller.isSelected(index)
                ? Border.all(color: Colors.orangeAccent, width: 2)
                : Theme.of(context).extension<ContainerBorderTheme>()!.border,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.network(
                    image_url,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Theme.of(context).primaryColor.withOpacity(0.7),
                  )),
              AppTextStyles.mediumVerticalSpacing,
              Text(
                name,
                style: AppTextStyles.subHeaderStyle,
              )
            ],
          ),
        ),
      );
    });
  }
}