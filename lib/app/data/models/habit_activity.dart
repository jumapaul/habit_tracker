class HabitActivity {
  String? docId;
  final String activityTitle;
  final String activityCategory;
  final String activityCategoryIcon;
  final String activityDesc;
  final String activityDate;
  final String activityFromTime;
  final String activityToTime;
  final String userId;
  final bool isCompleted;

  HabitActivity(
      {this.docId,
      required this.activityTitle,
      required this.activityCategory,
      required this.activityCategoryIcon,
      required this.activityDesc,
      required this.activityDate,
      required this.activityFromTime,
      required this.activityToTime,
      required this.userId,
      required this.isCompleted});

  HabitActivity copyWith({
    String? docId,
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
        docId: docId ?? this.docId,
        activityTitle: activityTitle ?? this.activityTitle,
        activityCategory: activityCategory ?? this.activityCategory,
        activityCategoryIcon: activityCategoryIcon ?? this.activityCategoryIcon,
        activityDesc: activityDesc ?? this.activityDesc,
        activityDate: activityDate ?? this.activityDate,
        activityFromTime: activityFromTime ?? this.activityFromTime,
        activityToTime: activityToTime ?? this.activityToTime,
        userId: userId ?? this.userId,
        isCompleted: isCompleted ?? this.isCompleted);
  }

  factory HabitActivity.fromJson(Map<String, dynamic> json, {String? docId}) {
    return HabitActivity(
        docId: json['doc_id'] ?? '',
        activityTitle: json['activity_title'] ?? '',
        activityCategory: json['activity_category'] ?? '',
        activityCategoryIcon: json['activity_category_icon'] ?? '',
        activityDesc: json['activity_desc'] ?? '',
        activityDate: json['activity_date'] ?? '',
        activityFromTime: json['activity_from_time'] ?? '',
        activityToTime: json['activity_to_time'] ?? '',
        userId: json['user_id'] ?? '',
        isCompleted: json['is_completed'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'doc_id': docId,
      'activity_title': activityTitle,
      'activity_category': activityCategory,
      'activity_category_icon': activityCategoryIcon,
      'activity_desc': activityDesc,
      'activity_date': activityDate,
      'activity_from_time': activityFromTime,
      'activity_to_time': activityToTime,
      'user_id': userId,
      'is_completed': isCompleted
    };
  }
}
