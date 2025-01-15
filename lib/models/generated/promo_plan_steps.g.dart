// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../promo_plan_steps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoPlanStepsDto _$PromoPlanStepsDtoFromJson(Map<String, dynamic> json) =>
    PromoPlanStepsDto(
      id: json['id'] as int?,
      value: json['value'] as int?,
      bonus: json['bonus'] as int?,
      isRepeatable: json['is_repeatable'] as bool?,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$PromoPlanStepsDtoToJson(PromoPlanStepsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'bonus': instance.bonus,
      'is_repeatable': instance.isRepeatable,
      'count': instance.count,
    };
