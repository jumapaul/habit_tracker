import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  uploadActivity(BuildContext context) async {
    var userId = FirebaseAuth.instance.currentUser?.uid;

    if (habitTitleController.text.isNotEmpty &&
        categoryController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        fromTimeController.text.isNotEmpty &&
        toTimeController.text.isNotEmpty) {
      var body = HabitActivity(
          activityTitle: habitTitleController.text,
          activityCategory: categoryController.text,
          activityCategoryIcon: categoryIcon.value,
          activityDesc: habitDescriptionController.text,
          activityDate: dateController.text,
          activityFromTime: fromTimeController.text,
          activityToTime: toTimeController.text,
          userId: userId!,
          isCompleted: false);
      await apiProvider.createActivity(userId, body).then((value) {
        fetchActivities();
        clearController();
        Get.back();
      });
    } else {
      Fluttertoast.showToast(
          msg: 'Ensure you fill all the fields', gravity: ToastGravity.BOTTOM);
    }
  }

  updateActivity(String docId, bool isComplete, String acivityTitle) async {
    var userId = FirebaseAuth.instance.currentUser?.uid;

    await apiProvider
        .updateActivity(userId!, docId, isComplete, acivityTitle)
        .then((_) {
      fetchActivities();
    });
  }

  void fetchActivities() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var activities =
        await apiProvider.getActivitiesByDate(userId, selectedDate.value);

    if (activities != null) {
      dailyActivity.value = activities;
    } else {
      dailyActivity.value = [];
    }
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
    selectedDate.value = dateToAssign;
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

  selectViewDate(BuildContext context) async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    selectedDate.value = date ?? DateTime.now();
    fetchActivities();
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
