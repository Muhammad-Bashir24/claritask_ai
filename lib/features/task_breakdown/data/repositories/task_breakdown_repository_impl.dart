import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/task_step.dart';
import '../../domain/repositories/task_breakdown_repository.dart';
import '../datasources/task_breakdown_remote_datasource.dart';

@LazySingleton(as: TaskBreakdownRepository)
class TaskBreakdownRepositoryImpl implements TaskBreakdownRepository {
  final TaskBreakdownRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  TaskBreakdownRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, List<TaskStep>>> breakdownTask(String taskId) async {
    if (await _networkInfo.isConnected) {
      try {
        final stepsModel = await _remoteDataSource.breakdownTask(taskId);
        return Right(stepsModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(UnknownFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<TaskStep>>> getTaskSteps(String taskId) async {
    if (await _networkInfo.isConnected) {
      try {
        final stepsModel = await _remoteDataSource.getTaskSteps(taskId);
        return Right(stepsModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(UnknownFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> updateTaskStepCompletion(
    String stepId,
    bool isCompleted,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.updateTaskStepCompletion(stepId, isCompleted);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(UnknownFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}
