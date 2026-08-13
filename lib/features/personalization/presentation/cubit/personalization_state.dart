import 'package:equatable/equatable.dart';

class PersonalizationState extends Equatable {
  final int currentStep;
  final String? primaryUsage;
  final List<String> userTypes;
  final String? biggestChallenge;
  final String? taskFrequency;
  final List<String> taskTypes;
  final bool isSubmitting;
  final String? errorMessage;
  final bool isSuccess;

  const PersonalizationState({
    this.currentStep = 1,
    this.primaryUsage,
    this.userTypes = const [],
    this.biggestChallenge,
    this.taskFrequency,
    this.taskTypes = const [],
    this.isSubmitting = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  PersonalizationState copyWith({
    int? currentStep,
    String? primaryUsage,
    List<String>? userTypes,
    String? biggestChallenge,
    String? taskFrequency,
    List<String>? taskTypes,
    bool? isSubmitting,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return PersonalizationState(
      currentStep: currentStep ?? this.currentStep,
      primaryUsage: primaryUsage ?? this.primaryUsage,
      userTypes: userTypes ?? this.userTypes,
      biggestChallenge: biggestChallenge ?? this.biggestChallenge,
      taskFrequency: taskFrequency ?? this.taskFrequency,
      taskTypes: taskTypes ?? this.taskTypes,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  // Clear error message explicitly
  PersonalizationState clearError() {
    return PersonalizationState(
      currentStep: currentStep,
      primaryUsage: primaryUsage,
      userTypes: userTypes,
      biggestChallenge: biggestChallenge,
      taskFrequency: taskFrequency,
      taskTypes: taskTypes,
      isSubmitting: isSubmitting,
      errorMessage: null,
      isSuccess: isSuccess,
    );
  }

  bool get canContinue {
    switch (currentStep) {
      case 1:
        return primaryUsage != null;
      case 2:
        return userTypes.isNotEmpty;
      case 3:
        return biggestChallenge != null;
      case 4:
        return taskFrequency != null;
      case 5:
        return taskTypes.isNotEmpty;
      default:
        return false;
    }
  }

  @override
  List<Object?> get props => [
    currentStep,
    primaryUsage,
    userTypes,
    biggestChallenge,
    taskFrequency,
    taskTypes,
    isSubmitting,
    errorMessage,
    isSuccess,
  ];
}
