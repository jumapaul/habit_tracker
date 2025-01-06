import 'habit_type.dart';

class Habit {
  String id; // Unique identifier for the habit
  String name; // Name of the habit
  String description; // Description of the habit
  HabitType type; // Type of habit (using the HabitType enum)
  String
      frequency; // How often the habit should be performed (e.g., daily, weekly)
  bool isCompleted; // Whether the habit is completed for the day/week
  DateTime date; // The date associated with this habit (e.g., today's date)

  // Constructor to initialize the Habit object
  Habit({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.frequency,
    this.isCompleted = false,
    required this.date,
  });

  // Method to mark the habit as completed
  void markAsCompleted() {
    isCompleted = true;
  }

  // Method to reset the completion status (e.g., for the next day)
  void resetCompletion() {
    isCompleted = false;
  }

  // Method to display habit details
  String getDetails() {
    return 'Habit: $name\nDescription: $description\nType: $type\nFrequency: $frequency\nCompleted: $isCompleted\nDate: ${date.toLocal()}';
  }

  // Method to update the habit's details
  void updateHabit({
    String? newName,
    String? newDescription,
    HabitType? newType,
    String? newFrequency,
    DateTime? newDate,
  }) {
    if (newName != null) {
      name = newName;
    }
    if (newDescription != null) {
      description = newDescription;
    }
    if (newType != null) {
      type = newType;
    }
    if (newFrequency != null) {
      frequency = newFrequency;
    }
    if (newDate != null) {
      date = newDate;
    }
  }

  // Method to delete the habit
  void deleteHabit() {
    // This would typically interact with a database or state management system to remove the habit
    print('Habit $name has been deleted.');
  }
}
