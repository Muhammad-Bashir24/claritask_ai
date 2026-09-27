import 'package:claritask_ai/core/error/failure.dart';
import 'package:claritask_ai/features/tasks/domain/entities/task.dart';
import 'package:dartz/dartz.dart' hide Task;

abstract class TaskRepository {
  Future<Either<Failure, Task>> createTask(String title);
}
