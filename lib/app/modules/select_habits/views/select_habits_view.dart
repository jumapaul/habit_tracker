import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:habit_tracker/app/common/dimens/dimens.dart';

import '../controllers/select_habits_controller.dart';

class SelectHabitsView extends GetView<SelectHabitsController> {
  const SelectHabitsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Choose habit',
                style: AppTextStyles.headerStyle,
              ),

              AppTextStyles.mediumVerticalSpacing,

              Text('Choose your daily habit, you can choose more than one')
            ],
          ),
        ));
  }

  _buildHabitItem(String imageUrl, String name) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: Colors.orangeAccent,
              width: 1
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imageUrl),
          AppTextStyles.mediumVerticalSpacing,
          Text(name, style: AppTextStyles.subHeaderStyle,)
        ],
      ),
    );
  }
}
