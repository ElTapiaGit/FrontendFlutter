import 'package:json_annotation/json_annotation.dart';

part 'meal_plan_create.g.dart';

@JsonSerializable()
class MealPlanCreate {
  final String studentId;
  final String? startDate;
  final List<String> breakfast;
  final String breakfastReminderTime;
  final List<String>? snackMorning;
  final List<String> lunch;
  final String lunchReminderTime;
  final List<String>? snackAfternoon;
  final List<String> dinner;
  final String dinnerReminderTime;
  final HydrationCreate hydration;
  final String? recommendations;
  final String? supplementRecommendations;

  MealPlanCreate({
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

  factory MealPlanCreate.fromJson(Map<String, dynamic> json) =>
      _$MealPlanCreateFromJson(json);
  Map<String, dynamic> toJson() => _$MealPlanCreateToJson(this);
}

@JsonSerializable()
class HydrationCreate {
  final double recommendedLiters;
  final String reminderTime;

  HydrationCreate({
    required this.recommendedLiters,
    required this.reminderTime,
  });

  factory HydrationCreate.fromJson(Map<String, dynamic> json) =>
      _$HydrationCreateFromJson(json);
  Map<String, dynamic> toJson() => _$HydrationCreateToJson(this);
}
