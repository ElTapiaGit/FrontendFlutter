// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealPlanResponse _$MealPlanResponseFromJson(Map<String, dynamic> json) =>
    MealPlanResponse(
      mealPlans: (json['mealPlans'] as List<dynamic>)
          .map((e) => MealPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealPlanResponseToJson(MealPlanResponse instance) =>
    <String, dynamic>{
      'mealPlans': instance.mealPlans,
    };
