// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealPlan _$MealPlanFromJson(Map<String, dynamic> json) => MealPlan(
      studentId: json['studentId'] as String,
      startDate: json['startDate'] as String,
      breakfast:
          (json['breakfast'] as List<dynamic>).map((e) => e as String).toList(),
      breakfastReminderTime: json['breakfastReminderTime'] as String,
      snackMorning: (json['snackMorning'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lunch: (json['lunch'] as List<dynamic>).map((e) => e as String).toList(),
      lunchReminderTime: json['lunchReminderTime'] as String,
      snackAfternoon: (json['snackAfternoon'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      dinner:
          (json['dinner'] as List<dynamic>).map((e) => e as String).toList(),
      dinnerReminderTime: json['dinnerReminderTime'] as String,
      hydration: Hydration.fromJson(json['hydration'] as Map<String, dynamic>),
      recommendations: json['recommendations'] as String,
      supplementRecommendations: json['supplementRecommendations'] as String?,
    );

Map<String, dynamic> _$MealPlanToJson(MealPlan instance) => <String, dynamic>{
      'studentId': instance.studentId,
      'startDate': instance.startDate,
      'breakfast': instance.breakfast,
      'breakfastReminderTime': instance.breakfastReminderTime,
      'snackMorning': instance.snackMorning,
      'lunch': instance.lunch,
      'lunchReminderTime': instance.lunchReminderTime,
      'snackAfternoon': instance.snackAfternoon,
      'dinner': instance.dinner,
      'dinnerReminderTime': instance.dinnerReminderTime,
      'hydration': instance.hydration,
      'recommendations': instance.recommendations,
      'supplementRecommendations': instance.supplementRecommendations,
    };

Hydration _$HydrationFromJson(Map<String, dynamic> json) => Hydration(
      recommendedLiters: (json['recommendedLiters'] as num).toDouble(),
      reminderTime: json['reminderTime'] as String,
    );

Map<String, dynamic> _$HydrationToJson(Hydration instance) => <String, dynamic>{
      'recommendedLiters': instance.recommendedLiters,
      'reminderTime': instance.reminderTime,
    };
