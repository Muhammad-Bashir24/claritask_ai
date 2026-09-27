import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../repositories/task_breakdown_repository.dart';

@lazySingleton
class UpdateTaskStepUseCase {
  final TaskBreakdownRepository _repository;

  UpdateTaskStepUseCase(this._repository);

  Future<Either<Failure, void>> call(String stepId, bool isCompleted) async {
    return await _repository.updateTaskStepCompletion(stepId, isCompleted);
  }
}
