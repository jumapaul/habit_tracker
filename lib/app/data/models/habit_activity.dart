class HabitActivity {
  final String activityTitle;
  final String activityCategory;
  final String activityCategoryIcon;
  final String activityDesc;
  final String activityDate;
  final String activityFromTime;
  final String activityToTime;
  final String userId;

  HabitActivity({
    required this.activityTitle,
    required this.activityCategory,
    required this.activityCategoryIcon,
    required this.activityDesc,
    required this.activityDate,
    required this.activityFromTime,
    required this.activityToTime,
    required this.userId,
  });

  HabitActivity copyWith({
    String? activityTitle,
    String? activityCategory,
    String? activityCategoryIcon,
    String? activityDesc,
    String? activityDate,
    String? activityFromTime,
    String? activityToTime,
    String? userId,
  }) {
    return HabitActivity(
      activityTitle: activityTitle ?? this.activityTitle,
      activityCategory: activityCategory ?? this.activityCategory,
      activityCategoryIcon: activityCategoryIcon ?? this.activityCategoryIcon,
      activityDesc: activityDesc ?? this.activityDesc,
      activityDate: activityDate ?? this.activityDate,
      activityFromTime: activityFromTime ?? this.activityFromTime,
      activityToTime: activityToTime ?? this.activityToTime,
      userId: userId ?? this.userId,
    );
  }

  factory HabitActivity.fromJson(Map<String, dynamic> json, {String? docId}) {
    return HabitActivity(
      activityTitle: json['activity_title'] ?? '',
      activityCategory: json['activity_category'] ?? '',
      activityCategoryIcon: json['activity_category_icon'] ?? '',
      activityDesc: json['activity_desc'] ?? '',
      activityDate: json['activity_date'] ?? '',
      activityFromTime: json['activity_from_time'] ?? '',
      activityToTime: json['activity_to_time'] ?? '',
      userId: json['user_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activity_title': activityTitle,
      'activity_category': activityCategory,
      'activity_category_icon': activityCategoryIcon,
      'activity_desc': activityDesc,
      'activity_date': activityDate,
      'activity_from_time': activityFromTime,
      'activity_to_time': activityToTime,
      'user_id': userId,
    };
  }
}
