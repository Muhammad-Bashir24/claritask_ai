import 'package:claritask_ai/features/authentication/data/models/user_model.dart';
import 'package:claritask_ai/features/authentication/domain/entities/auth_session_state.dart';

abstract interface class AuthRemoteDataSource {
  Stream<AuthSessionState> get authStateChanges;

  Future<void> updatePassword(String newPassword);

  Future<UserModel> login({required String email, required String password});

  Future<UserModel> register({
    required String email,
    required String password,
    required String fullName,
  });

  Future<UserModel> googleSignIn();

  Future<void> logout();

  Future<UserModel?> currentUser();

  Future<void> resetPassword({required String email});
}
