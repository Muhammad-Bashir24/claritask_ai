import 'package:claritask_ai/core/utils/typedefs.dart';
import 'package:claritask_ai/features/authentication/domain/entities/user_entity.dart';
import 'package:claritask_ai/features/authentication/domain/entities/auth_session_state.dart';

abstract interface class AuthRepository {
  Stream<AuthSessionState> get authStateChanges;

  ResultVoid updatePassword(String newPassword);

  ResultFuture<UserEntity> login({
    required String email,
    required String password,
  });

  ResultFuture<UserEntity> register({
    required String email,
    required String password,
    required String fullName,
  });

  ResultFuture<UserEntity> googleSignIn();

  ResultFuture<void> logout();

  ResultFuture<UserEntity?> currentUser();

  ResultVoid resetPassword({required String email});
}
