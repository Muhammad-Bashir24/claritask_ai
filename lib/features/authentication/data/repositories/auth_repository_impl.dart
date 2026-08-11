import 'package:claritask_ai/core/error/exceptions.dart';
import 'package:claritask_ai/core/error/failure.dart';
import 'package:claritask_ai/core/network/network_info.dart';
import 'package:claritask_ai/core/utils/typedefs.dart';
import 'package:claritask_ai/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:claritask_ai/features/authentication/domain/entities/user_entity.dart';
import 'package:claritask_ai/features/authentication/domain/entities/auth_session_state.dart';
import 'package:claritask_ai/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(this._remote, this._networkInfo);

  @override
  Stream<AuthSessionState> get authStateChanges => _remote.authStateChanges;

  @override
  ResultVoid updatePassword(String newPassword) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection.'));
    }
    try {
      await _remote.updatePassword(newPassword);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure('Unable to update password.'));
    }
  }

  @override
  ResultFuture<UserEntity> login({
    required String email,
    required String password,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection.'));
    }

    try {
      final user = await _remote.login(email: email, password: password);

      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure('Something went wrong.'));
    }
  }

  @override
  ResultFuture<UserEntity> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection.'));
    }

    try {
      final user = await _remote.register(
        email: email,
        password: password,
        fullName: fullName,
      );

      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure('Something went wrong.'));
    }
  }

  @override
  ResultFuture<UserEntity?> currentUser() async {
    try {
      final user = await _remote.currentUser();

      return Right(user);
    } catch (_) {
      return const Left(UnknownFailure('Unable to retrieve current user.'));
    }
  }

  @override
  ResultVoid resetPassword({required String email}) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection.'));
    }
    try {
      await _remote.resetPassword(email: email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure('Unable to retrieve current user.'));
    }
  }

  @override
  ResultFuture<UserEntity> googleSignIn() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection.'));
    }

    try {
      final user = await _remote.googleSignIn();
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure('Something went wrong.'));
    }
  }

  @override
  ResultFuture<void> logout() async {
    // TODO: implement logout
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }
    try {
      await _remote.logout();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure('Something went wrong.'));
    }
  }
}
