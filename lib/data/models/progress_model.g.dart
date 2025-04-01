// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgressRequest _$ProgressFromJson(Map<String, dynamic> json) => ProgressRequest(
      studentId: json['studentId'] as String,
      weight: (json['weight'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      activityLevels: json['activityLevels'] as String,
      //date:  json['date'] as DateTime,
      objectives: json['objectives'] as String,
    );

Map<String, dynamic> _$ProgressToJson(ProgressRequest instance) => <String, dynamic>{
      'studentId': instance.studentId,
      'weight': instance.weight,
      'height': instance.height,
      'activityLevels': instance.activityLevels,
      //'date': instance.date,
      'objectives': instance.objectives    
      };