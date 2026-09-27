import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/task_step.dart';

abstract class TaskBreakdownRepository {
  Future<Either<Failure, List<TaskStep>>> breakdownTask(String taskId);
  Future<Either<Failure, List<TaskStep>>> getTaskSteps(String taskId);
  Future<Either<Failure, void>> updateTaskStepCompletion(
    String stepId,
    bool isCompleted,
  );
}
