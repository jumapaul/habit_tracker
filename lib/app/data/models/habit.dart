class HabitTypes {
  final String id;
  final String title;
  final String imageUrl;

  HabitTypes({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  // Add this method
  HabitTypes copyWith({
    String? id,
    String? title,
    String? imageUrl,
  }) {
    return HabitTypes(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory HabitTypes.fromJson(Map<String, dynamic> json, {String? docId}) {
    return HabitTypes(
      id: docId ?? json['id'] ?? '',
      title: json['title'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image_url': imageUrl,
    };
  }
}