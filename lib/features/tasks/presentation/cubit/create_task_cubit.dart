import 'package:claritask_ai/features/tasks/domain/usecases/create_task.dart';
import 'package:claritask_ai/features/tasks/presentation/cubit/create_task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  final CreateTaskUseCase createTaskUseCase;

  CreateTaskCubit(this.createTaskUseCase) : super(CreateTaskInitial());

  Future<void> createTask(String title) async {
    if (state is CreateTaskLoading) return;

    emit(CreateTaskLoading());

    final result = await createTaskUseCase(title);

    result.fold(
      (failure) => emit(CreateTaskError(failure.message)),
      (task) => emit(CreateTaskSuccess(task)),
    );
  }

  void clearError() {
    if (state is CreateTaskError) {
      emit(CreateTaskInitial());
    }
  }
}
