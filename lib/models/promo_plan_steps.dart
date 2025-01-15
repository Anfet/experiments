import 'package:json_annotation/json_annotation.dart';

part 'generated/promo_plan_steps.g.dart';

@JsonSerializable()
class PromoPlanStepsDto {
  final int? id;
  final int? value;
  final int? bonus;
  @JsonKey(name: 'is_repeatable')
  final bool? isRepeatable;
  final int? count;

  PromoPlanStepsDto({
    this.id,
    this.value,
    this.bonus,
    this.isRepeatable,
    this.count,
  });

  factory PromoPlanStepsDto.fromJson(Map<String, dynamic> json) => _$PromoPlanStepsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PromoPlanStepsDtoToJson(this);
}
