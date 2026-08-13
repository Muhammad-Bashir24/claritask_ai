import 'package:equatable/equatable.dart';

class PersonalizationEntity extends Equatable {
  final String primaryUsage;
  final List<String> userTypes;
  final String biggestChallenge;
  final String taskFrequency;
  final List<String> taskTypes;

  const PersonalizationEntity({
    required this.primaryUsage,
    required this.userTypes,
    required this.biggestChallenge,
    required this.taskFrequency,
    required this.taskTypes,
  });

  @override
  List<Object?> get props => [
    primaryUsage,
    userTypes,
    biggestChallenge,
    taskFrequency,
    taskTypes,
  ];
}
