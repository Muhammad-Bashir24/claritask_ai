import 'package:claritask_ai/core/error/exceptions.dart';
import 'package:claritask_ai/core/error/failure.dart';
import 'package:claritask_ai/core/network/network_info.dart';
import 'package:claritask_ai/core/utils/typedefs.dart';
import 'package:claritask_ai/features/personalization/data/datasources/personalization_remote_datasource.dart';
import 'package:claritask_ai/features/personalization/data/models/personalization_model.dart';
import 'package:claritask_ai/features/personalization/domain/entities/personalization.dart';
import 'package:claritask_ai/features/personalization/domain/repositories/personalization_repository.dart';
import 'package:dartz/dartz.dart';

class PersonalizationRepositoryImpl implements PersonalizationRepository {
  final PersonalizationRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  PersonalizationRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  ResultVoid savePersonalization(PersonalizationEntity personalization) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection.'));
    }

    try {
      final model = PersonalizationModel.fromEntity(personalization);
      await _remoteDataSource.savePersonalization(model);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure('Something went wrong.'));
    }
  }

  @override
  ResultFuture<bool> checkOnboardingCompleted() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection.'));
    }

    try {
      final isCompleted = await _remoteDataSource.checkOnboardingCompleted();
      return Right(isCompleted);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure('Something went wrong.'));
    }
  }

  @override
  ResultFuture<PersonalizationEntity?> getPersonalization() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection.'));
    }

    try {
      final personalization = await _remoteDataSource.getPersonalization();
      return Right(personalization);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure('Something went wrong.'));
    }
  }
}
