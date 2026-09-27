import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../entities/task_step.dart';
import '../repositories/task_breakdown_repository.dart';

@lazySingleton
class BreakdownTaskUseCase {
  final TaskBreakdownRepository _repository;

  BreakdownTaskUseCase(this._repository);

  Future<Either<Failure, List<TaskStep>>> call(String taskId) async {
    return await _repository.breakdownTask(taskId);
  }
}
