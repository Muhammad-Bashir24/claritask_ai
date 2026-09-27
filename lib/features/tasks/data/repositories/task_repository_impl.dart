import 'package:claritask_ai/core/error/exceptions.dart';
import 'package:claritask_ai/core/error/failure.dart';
import 'package:claritask_ai/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:claritask_ai/features/tasks/domain/entities/task.dart';
import 'package:claritask_ai/features/tasks/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart' hide Task;

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Task>> createTask(String title) async {
    try {
      final task = await remoteDataSource.createTask(title);
      return Right(task);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(UnknownFailure('An unexpected error occurred.'));
    }
  }
}
