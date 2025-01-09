import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/habit_activity.dart';
import '../../../data/providers/api_provider.dart';

class StatsController extends GetxController {
  var currentDay = ''.obs;
  final ApiProvider apiProvider = ApiProvider();
  final reportPeriod = 'Daily'.obs;

  final RxList<ActivityGroup> dailyActivityByCategory =
      RxList<ActivityGroup>([]);

  final RxString highestDurationCategoryName = ''.obs;
  final RxInt highestDurationValue = 0.obs;

  final RxString lowestDurationCategoryName = ''.obs;
  final RxInt lowestDurationValue = 0.obs;

  void getDailyReport() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var selectedDate = DateTime.now().obs;
    var activities =
        await apiProvider.getActivitiesByDate(userId, selectedDate.value);

    groupActivitiesToCategory(activities);
  }

  getWeeklyReport() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var activities =
        await apiProvider.getActivityByWeek(userId, DateTime.now());
    groupActivitiesToCategory(activities);
  }

  getMonthlyReport() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var activities =
        await apiProvider.getActivityByMonth(userId, DateTime.now());
    groupActivitiesToCategory(activities);
  }

  groupActivitiesToCategory(List<HabitActivity>? activities) {
    if (activities != null) {
      Map<String, List<HabitActivity>> groupedActivities = {};

      for (var activity in activities) {
        if (!groupedActivities.containsKey(activity.activityCategory)) {
          groupedActivities[activity.activityCategory] = [];
        }
        groupedActivities[activity.activityCategory]!.add(activity);
      }

      var groupedList = groupedActivities.entries.map((entry) {
        return ActivityGroup(
          category: entry.key,
          activities: entry.value,
          totalCount: entry.value.length,
          totalDuration: entry.value.fold(0, (sum, activity) {
            if (!activity.isCompleted) return sum;
            final duration = getTimeDifference(
                activity.activityFromTime, activity.activityToTime);
            return sum + duration;
          }),
          categoryIconUrl: entry.value.isNotEmpty
              ? entry.value.first.activityCategoryIcon
              : '',
        );
      }).toList();
      findHighestDurationCategory(groupedList);
      dailyActivityByCategory.value = groupedList;
    } else {
      dailyActivityByCategory.value = [];
    }
  }

  int getTimeDifference(String activityBeginTime, activityEndTime) {
    final start = activityBeginTime.split(':');
    final end = activityEndTime.split(':');

    final startTime = DateTime(
        DateTime.now().year, 1, 1, int.parse(start[0]), int.parse(start[1]));

    final endTime = DateTime(
        DateTime.now().year, 1, 1, int.parse(end[0]), int.parse(end[1]));

    return endTime.difference(startTime).inHours.abs();
  }

  void findHighestDurationCategory(List<ActivityGroup> group) {
    if (group.isNotEmpty) {
      var lowest = group.reduce((current, next) =>
          current.totalDuration < next.totalDuration ? current : next);

      var highest = group.reduce((current, next) =>
          current.totalDuration > next.totalDuration ? current : next);

      lowestDurationValue.value = lowest.totalDuration;
      lowestDurationCategoryName.value = lowest.category;

      highestDurationValue.value = highest.totalDuration;
      highestDurationCategoryName.value = highest.category;
    } else {
      lowestDurationValue.value = 0;
      lowestDurationCategoryName.value = '';
      highestDurationValue.value = 0;
      highestDurationCategoryName.value = '';
    }
  }

  void dissectCurrentDay() {
    var now = DateTime.now();
    var year = DateTime.now().year;
    var date = now.day;
    var day = DateFormat('E').format(now);

    currentDay.value = '$day $date $year';
  }

  @override
  void onInit() {
    getDailyReport();
    dissectCurrentDay();
    super.onInit();
  }

  @override
  void onReady() {
    getDailyReport();
    super.onReady();
  }

  @override
  void onClose() {
    getDailyReport();
    super.onClose();
  }
}

class ActivityGroup {
  final String category;
  final List<HabitActivity> activities;
  final int totalCount;
  final int totalDuration;
  final String categoryIconUrl;

  ActivityGroup(
      {required this.category,
      required this.activities,
      required this.totalCount,
      required this.totalDuration,
      required this.categoryIconUrl});
}
