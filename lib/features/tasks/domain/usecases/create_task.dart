import 'package:claritask_ai/core/error/failure.dart';
import 'package:claritask_ai/features/tasks/domain/entities/task.dart';
import 'package:claritask_ai/features/tasks/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart' hide Task;

class CreateTaskUseCase {
  final TaskRepository repository;

  CreateTaskUseCase(this.repository);

  Future<Either<Failure, Task>> call(String title) async {
    final trimmedTitle = title.trim();

    if (trimmedTitle.isEmpty) {
      return const Left(ValidationFailure('Task title cannot be empty.'));
    }

    if (trimmedTitle.length > 500) {
      return const Left(
        ValidationFailure(
          'Your task is too long. Try keeping it under 500 characters.',
        ),
      );
    }

    return await repository.createTask(trimmedTitle);
  }
}
