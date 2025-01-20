import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/app/common/custom_theme/container_border_theme.dart';
import 'package:habit_tracker/app/common/dimens/dimens.dart';
import 'package:habit_tracker/app/data/models/habit.dart';
import 'package:habit_tracker/app/data/models/habit_activity.dart';
import 'package:habit_tracker/app/modules/auth/widgets/outlined_input_text_widget.dart';
import 'package:habit_tracker/app/modules/common_widget/outlined_button_widget.dart';
import 'package:habit_tracker/app/services/notification_service.dart';
import 'package:intl/intl.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Obx(() {
              var activities = controller.dailyActivity;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
              //     DateTime scheduleDate =
              //     DateTime.now().add(Duration(seconds: 3));
              // NotificationService.scheduleNotification(
              //     'Time', 'Get ready', scheduleDate);
                      _buildTopBarIcons(Icons.person, context),
                      Text(controller.currentDay.value),
                      GestureDetector(
                        onTap: () => controller.selectViewDate(context),
                        child: _buildTopBarIcons(Icons.calendar_month, context),
                      )
                    ],
                  ),
                  AppTextStyles.mediumVerticalSpacing,
                  _buildHorizontalCalender(context),
                  AppTextStyles.largeVerticalSpacing,
                  activities.isEmpty
                      ? Center(
                          child: Text('No activity'),
                        )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: activities.length,
                          itemBuilder: (context, index) {
                            var singleHabit = activities[index];

                            return _buildActivityWidget(
                                singleHabit, context, singleHabit.isCompleted);
                          })
                ],
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _buildAddHabitBottomSheet(controller.habitsCategory, context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _buildTopBarIcons(IconData icon, BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Theme.of(context).extension<ContainerBorderTheme>()!.border,
      ),
      child: SizedBox(height: 20, width: 20, child: Icon(icon)),
    );
  }

  _buildHorizontalCalender(BuildContext context) {
    List<DateTime> weekDates = List.generate(7, (index) {
      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day).add(Duration(days: index));
    });
    return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: weekDates.length,
          itemBuilder: (context, index) {
            DateTime date = weekDates[index];

            return Obx(() {
              bool isSelected =
                  controller.selectedDate.value.year == date.year &&
                      controller.selectedDate.value.month == date.month &&
                      controller.selectedDate.value.day == date.day;
              return GestureDetector(
                onTap: () {
                  controller.selectedDate.value = date;
                  controller.fetchActivities();
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                      color: isSelected
                          ? (Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey
                              : Theme.of(context).primaryColor.withOpacity(0.5))
                          : (Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: isSelected
                              ? Theme.of(context).primaryColor.withOpacity(0.2)
                              : Colors.white,
                          width: 1)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('EEE').format(date),
                        style: AppTextStyles.largeSubHeaderStyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        DateFormat('dd').format(date),
                        style: AppTextStyles.headerStyle,
                      )
                    ],
                  ),
                ),
              );
            });
          }),
    );
  }

  _buildAddHabitBottomSheet(List<HabitTypes> habits, BuildContext context) {
    return Get.bottomSheet(
      backgroundColor: Colors.white,
      Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add today\'s Habit',
                  style: AppTextStyles.headerStyle,
                ),
                AppTextStyles.mediumVerticalSpacing,
                OutlinedInputTextFieldWidget(
                    labelText: 'Title',
                    hintText: 'Enter habit title',
                    editingController: controller.habitTitleController),
                AppTextStyles.mediumVerticalSpacing,
                _buildDropDownMenuForCategory(habits, context),
                AppTextStyles.mediumVerticalSpacing,
                OutlinedInputTextFieldWidget(
                    hintText: 'Enter habit description',
                    labelText: 'Description',
                    editingController: controller.habitDescriptionController),
                AppTextStyles.mediumVerticalSpacing,
                OutlinedInputTextFieldWidget(
                    onTap: () async {
                      controller.selectActivityDate(context);
                    },
                    readOnly: true,
                    labelText: 'Date',
                    editingController: controller.dateController),
                AppTextStyles.mediumVerticalSpacing,
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: OutlinedInputTextFieldWidget(
                            readOnly: true,
                            onTap: () => controller.selectTime(
                                context, controller.fromTimeController),
                            editingController: controller.fromTimeController,
                            labelText: 'From'),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: OutlinedInputTextFieldWidget(
                          readOnly: true,
                          onTap: () => controller.selectTime(
                              context, controller.toTimeController),
                          editingController: controller.toTimeController,
                          labelText: 'To',
                        ),
                      ),
                    ),
                  ],
                ),
                AppTextStyles.mediumVerticalSpacing,
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButtonWidget(
                        onClick: () {
                          controller.clearController();
                          Get.back();
                        },
                        name: 'Cancel',
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: OutlinedButtonWidget(
                          onClick: () {
                            controller.uploadActivity(context);
                          },
                          name: 'Add',
                        ),
                      ),
                    )
                  ],
                ),
                AppTextStyles.mediumVerticalSpacing,
                AppTextStyles.mediumVerticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildDropDownMenuForCategory(List<HabitTypes> habits, BuildContext context) {
    return DropdownMenu<HabitTypes>(
      alignmentOffset: Offset(40, -40),
        controller: controller.categoryController,
        width: double.infinity,
        hintText: 'Select Category',
        requestFocusOnTap: true,
        enableFilter: true,
        menuStyle: MenuStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        label: const Text('Categories'),
        onSelected: (HabitTypes? habit) {
          if (habit != null) {
            controller.categoryController.text = habit.title;
            controller.categoryIcon.value = habit.imageUrl;
          }
        },
        dropdownMenuEntries:
            habits.map<DropdownMenuEntry<HabitTypes>>((HabitTypes habit) {
          return DropdownMenuEntry<HabitTypes>(
              value: habit, label: habit.title);
        }).toList(),
    );
  }

  _buildActivityWidget(
      HabitActivity activity, BuildContext context, bool? isComplete) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Theme.of(context).extension<ContainerBorderTheme>()!.border,
      ),
      height: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Checkbox(
                value: isComplete,
                onChanged: (value) {
                  controller.updateActivity(
                      activity.docId!, value!, activity.activityTitle);
                },
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.network(
                    activity.activityCategoryIcon,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Theme.of(context).primaryColor.withOpacity(0.7),
                  )),
              AppTextStyles.smallVerticalSpacing,
              Text(
                activity.activityTitle,
                style: AppTextStyles.largeSubHeaderStyle,
              ),
              AppTextStyles.smallVerticalSpacing,
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Time: ${activity.activityFromTime} to ${activity.activityToTime}',
                  style: AppTextStyles.subHeaderStyle,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
