import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:claritask_ai/features/personalization/domain/entities/personalization.dart';
import 'package:claritask_ai/features/personalization/domain/usecases/save_personalization.dart';
import 'package:claritask_ai/features/personalization/presentation/cubit/personalization_state.dart';

class PersonalizationCubit extends Cubit<PersonalizationState> {
  final SavePersonalizationUseCase _savePersonalizationUseCase;

  PersonalizationCubit(this._savePersonalizationUseCase)
    : super(const PersonalizationState());

  void nextStep() {
    if (state.currentStep < 5 && state.canContinue) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void previousStep() {
    if (state.currentStep > 1) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void selectPrimaryUsage(String usage) {
    emit(state.copyWith(primaryUsage: usage));
  }

  void toggleUserType(String type) {
    final types = List<String>.from(state.userTypes);
    if (types.contains(type)) {
      types.remove(type);
    } else {
      types.add(type);
    }
    emit(state.copyWith(userTypes: types));
  }

  void selectBiggestChallenge(String challenge) {
    emit(state.copyWith(biggestChallenge: challenge));
  }

  void selectTaskFrequency(String frequency) {
    emit(state.copyWith(taskFrequency: frequency));
  }

  void toggleTaskType(String type) {
    final types = List<String>.from(state.taskTypes);
    if (types.contains(type)) {
      types.remove(type);
    } else {
      types.add(type);
    }
    emit(state.copyWith(taskTypes: types));
  }

  void resetError() {
    emit(state.clearError());
  }

  Future<void> submitPersonalization() async {
    if (!state.canContinue) return;
    if (state.isSubmitting) return;

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    final entity = PersonalizationEntity(
      primaryUsage: state.primaryUsage!,
      userTypes: state.userTypes,
      biggestChallenge: state.biggestChallenge!,
      taskFrequency: state.taskFrequency!,
      taskTypes: state.taskTypes,
    );

    final result = await _savePersonalizationUseCase(entity);

    result.fold(
      (failure) => emit(
        state.clearError().copyWith(
          isSubmitting: false,
          errorMessage: "Something went wrong. Please try again.",
        ),
      ),
      (_) => emit(
        state.clearError().copyWith(isSubmitting: false, isSuccess: true),
      ),
    );
  }
}
