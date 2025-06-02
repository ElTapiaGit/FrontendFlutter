// lib/data/models/meal_plan_response.dart

import 'package:json_annotation/json_annotation.dart';
import 'mealPlanHistory.dart';

part 'meal_plan_response.g.dart';

@JsonSerializable()
class MealPlanResponse {
  final List<MealPlan> mealPlans;

  MealPlanResponse({required this.mealPlans});

  factory MealPlanResponse.fromJson(Map<String, dynamic> json) =>
      _$MealPlanResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MealPlanResponseToJson(this);
}


