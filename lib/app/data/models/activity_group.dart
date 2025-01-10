import 'habit_activity.dart';

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