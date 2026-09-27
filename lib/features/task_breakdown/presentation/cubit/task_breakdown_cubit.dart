import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/task_step.dart';
import '../../domain/usecases/breakdown_task.dart';
import '../../domain/usecases/get_task_steps.dart';
import '../../domain/usecases/update_task_step.dart';
import 'task_breakdown_state.dart';

@injectable
class TaskBreakdownCubit extends Cubit<TaskBreakdownState> {
  final BreakdownTaskUseCase _breakdownTaskUseCase;
  final GetTaskStepsUseCase _getTaskStepsUseCase;
  final UpdateTaskStepUseCase _updateTaskStepUseCase;

  TaskBreakdownCubit(
    this._breakdownTaskUseCase,
    this._getTaskStepsUseCase,
    this._updateTaskStepUseCase,
  ) : super(TaskBreakdownInitial());

  Future<void> loadOrBreakdownTask(String taskId) async {
    if (state is TaskBreakdownLoading) return;

    emit(TaskBreakdownLoading());

    // First try to load existing steps
    final getStepsResult = await _getTaskStepsUseCase(taskId);

    await getStepsResult.fold(
      (failure) async {
        emit(TaskBreakdownError(failure.message));
      },
      (steps) async {
        if (steps.isNotEmpty) {
          emit(TaskBreakdownSuccess(steps));
        } else {
          // If no steps exist, break down the task
          await _performBreakdown(taskId);
        }
      },
    );
  }

  Future<void> _performBreakdown(String taskId) async {
    final result = await _breakdownTaskUseCase(taskId);

    result.fold(
      (failure) => emit(TaskBreakdownError(failure.message)),
      (steps) => emit(TaskBreakdownSuccess(steps)),
    );
  }

  Future<void> retryBreakdown(String taskId) async {
    emit(TaskBreakdownLoading());
    await _performBreakdown(taskId);
  }

  Future<void> toggleStepCompletion(TaskStep step) async {
    if (state is! TaskBreakdownSuccess) return;

    final currentState = state as TaskBreakdownSuccess;
    final updatedIsCompleted = !step.isCompleted;

    // Optimistically update the UI
    final updatedSteps = currentState.steps.map((s) {
      if (s.id == step.id) {
        return s.copyWith(isCompleted: updatedIsCompleted);
      }
      return s;
    }).toList();

    emit(TaskBreakdownSuccess(updatedSteps));

    // Perform the API call
    final result = await _updateTaskStepUseCase(step.id, updatedIsCompleted);

    result.fold(
      (failure) {
        // Revert on failure
        emit(TaskBreakdownError('Failed to update step: ${failure.message}'));
        emit(currentState);
      },
      (_) {
        // Ensure the task overall status is updated if needed.
        // The edge function or database triggers could handle task completion status,
        // or we could add another usecase to update the Task status here.
      },
    );
  }

  void reset() {
    emit(TaskBreakdownInitial());
  }
}
