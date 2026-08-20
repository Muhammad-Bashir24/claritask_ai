import 'package:claritask_ai/features/personalization/domain/entities/personalization.dart';

class PersonalizationModel extends PersonalizationEntity {
  const PersonalizationModel({
    required super.primaryUsage,
    required super.userTypes,
    required super.biggestChallenge,
    required super.taskFrequency,
    required super.taskTypes,
  });

  factory PersonalizationModel.fromEntity(PersonalizationEntity entity) {
    return PersonalizationModel(
      primaryUsage: entity.primaryUsage,
      userTypes: entity.userTypes,
      biggestChallenge: entity.biggestChallenge,
      taskFrequency: entity.taskFrequency,
      taskTypes: entity.taskTypes,
    );
  }

  factory PersonalizationModel.fromJson(Map<String, dynamic> json) {
    return PersonalizationModel(
      primaryUsage: json['primary_usage'] as String? ?? 'other',
      userTypes:
          (json['user_types'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      biggestChallenge: json['biggest_challenge'] as String? ?? 'other',
      taskFrequency: json['task_frequency'] as String? ?? 'occasionally',
      taskTypes:
          (json['task_types'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "primary_usage": primaryUsage,
      "user_types": userTypes,
      "biggest_challenge": biggestChallenge,
      "task_frequency": taskFrequency,
      "task_types": taskTypes,
    };
  }
}
