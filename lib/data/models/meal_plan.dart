import 'package:json_annotation/json_annotation.dart';

part 'meal_plan.g.dart';

@JsonSerializable()
class MealPlan {
  final String studentId;
  final String startDate;
  final List<String> breakfast;
  final String breakfastReminderTime;
  final List<String>? snackMorning;
  final List<String> lunch;
  final String lunchReminderTime;
  final List<String>? snackAfternoon;
  final List<String> dinner;
  final String dinnerReminderTime;
  final Hydration hydration;
  final String recommendations;
  final String? supplementRecommendations;

  MealPlan({
    required this.studentId,
    required this.startDate,
    required this.breakfast,
    required this.breakfastReminderTime,
    this.snackMorning,
    required this.lunch,
    required this.lunchReminderTime,
    this.snackAfternoon,
    required this.dinner,
    required this.dinnerReminderTime,
    required this.hydration,
    required this.recommendations,
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
