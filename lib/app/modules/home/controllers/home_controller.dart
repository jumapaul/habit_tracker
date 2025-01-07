import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/app/data/models/habit.dart';
import 'package:habit_tracker/app/data/models/habit_activity.dart';
import 'package:habit_tracker/app/data/providers/api_provider.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var currentDay = ''.obs;
  TextEditingController habitTitleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController habitDescriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();

  final ApiProvider apiProvider = ApiProvider();
  var habitsCategory = RxList<HabitTypes>();
  var dailyActivity = RxList<HabitActivity>();
  var categoryIcon = ''.obs;

  getHabitCategories() async {
    var selectedHabits = await apiProvider.getSelectedHabits();

    habitsCategory.value = selectedHabits!;
  }

  uploadActivity() {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var body = HabitActivity(
        activityTitle: habitTitleController.text,
        activityCategory: categoryController.text,
        activityCategoryIcon: categoryIcon.value,
        activityDesc: habitDescriptionController.text,
        activityDate: dateController.text,
        activityFromTime: fromTimeController.text,
        activityToTime: toTimeController.text,
        userId: userId!);
    apiProvider.createActivity(userId, body).then((value) {
      clearController();
      Get.back();
    });
  }

  void fetchActivities() async {
    print('============>called');
    var userId = FirebaseAuth.instance.currentUser!.uid;
    String formattedDate = '${selectedDate.value.toLocal()}'.split(' ')[0];

    print('------------>Formatted date');
    var activities =
        await apiProvider.getActivitiesByDate(userId, selectedDate.value);

    print('----------->activities $activities');
    if (activities != null) {
      dailyActivity.value = activities;
    } else {
      dailyActivity.value = [];
    }
  }

  void selectDate(DateTime date) {
    selectedDate.value = DateTime(date.year, date.month, date.day);
  }

  void dissectCurrentDay() {
    var now = DateTime.now();
    var date = now.day;
    var day = DateFormat('E').format(now);

    currentDay.value = '$day $date';
  }

  Future selectActivityDate(BuildContext context) async {
    var selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        selectableDayPredicate: (DateTime date) {
          return date.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
              date.isBefore(DateTime.now().add(Duration(days: 7)));
        });

    DateTime dateToAssign = selected ?? DateTime.now();
    dateController.text = "${dateToAssign.toLocal()}".split(' ')[0];
  }

  Future selectTime(
      BuildContext context, TextEditingController editText) async {
    final TimeOfDay currentTime = TimeOfDay.now();

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    final TimeOfDay timeToUse = selectedTime ?? currentTime;
    final String formattedHour = timeToUse.hour.toString().padLeft(2, '0');
    final String formattedMinutes = timeToUse.minute.toString().padLeft(2, '0');

    editText.text = '$formattedHour:$formattedMinutes';
  }

  clearController() {
    habitTitleController.clear();
    categoryController.clear();
    habitDescriptionController.clear();
    dateController.clear();
    fromTimeController.clear();
    toTimeController.clear();
  }

  @override
  void onInit() {
    dissectCurrentDay();
    getHabitCategories();
    fetchActivities();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    habitTitleController.dispose();
    categoryController.dispose();
    habitDescriptionController.dispose();
    dateController.dispose();
    fromTimeController.dispose();
    toTimeController.dispose();
    super.onClose();
  }
}
