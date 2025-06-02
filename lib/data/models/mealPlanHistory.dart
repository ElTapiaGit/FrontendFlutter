import 'package:json_annotation/json_annotation.dart';

part 'mealPlanHistory.g.dart';

@JsonSerializable()
class MealPlan {
  @JsonKey(name: 'student')
  final String studentId;
  final String? startDate;
  @JsonKey(defaultValue: [])
  final List<String> breakfast;
  final String breakfastReminderTime;
  @JsonKey(defaultValue: [])
  final List<String>? snackMorning;
  @JsonKey(defaultValue: [])
  final List<String> lunch;
  final String lunchReminderTime;
  @JsonKey(defaultValue: [])
  final List<String>? snackAfternoon;
  @JsonKey(defaultValue: [])
  final List<String> dinner;
  final String dinnerReminderTime;
  final Hydration hydration;
  final String? recommendations;
  final String? supplementRecommendations;

  MealPlan({
    required this.studentId,
    this.startDate,
    required this.breakfast,
    required this.breakfastReminderTime,
    this.snackMorning,
    required this.lunch,
    required this.lunchReminderTime,
    this.snackAfternoon,
    required this.dinner,
    required this.dinnerReminderTime,
    required this.hydration,
    this.recommendations,
    this.supplementRecommendations,
  });

  factory MealPlan.fromJson(Map<String, dynamic> json) => _$MealPlanFromJson(json);
  Map<String, dynamic> toJson() => _$MealPlanToJson(this);
}

@JsonSerializable()
class Hydration {
  final double recommendedLiters;
  final String reminderTime;

  Hydration({
    required this.recommendedLiters,
    required this.reminderTime,
  });

  factory Hydration.fromJson(Map<String, dynamic> json) => _$HydrationFromJson(json);
  Map<String, dynamic> toJson() => _$HydrationToJson(this);
}
