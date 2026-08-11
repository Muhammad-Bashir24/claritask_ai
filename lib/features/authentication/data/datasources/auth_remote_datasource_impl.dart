import 'package:claritask_ai/core/error/exceptions.dart';
import 'package:claritask_ai/core/services/google_sign_in_service.dart';
import 'package:claritask_ai/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:claritask_ai/features/authentication/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:claritask_ai/features/authentication/domain/entities/auth_session_state.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDataSource {
  final supabase.SupabaseClient _client;

  AuthRemoteDatasourceImpl(this._client);

  @override
  Stream<AuthSessionState> get authStateChanges => _client.auth.onAuthStateChange.map((authState) {
        final user = authState.session?.user;
        DomainAuthEvent domainEvent;
        switch (authState.event) {
          case supabase.AuthChangeEvent.initialSession:
            domainEvent = DomainAuthEvent.initialSession;
            break;
          case supabase.AuthChangeEvent.signedIn:
            domainEvent = DomainAuthEvent.signedIn;
            break;
          case supabase.AuthChangeEvent.signedOut:
            domainEvent = DomainAuthEvent.signedOut;
            break;
          case supabase.AuthChangeEvent.passwordRecovery:
            domainEvent = DomainAuthEvent.passwordRecovery;
            break;
          case supabase.AuthChangeEvent.userUpdated:
            domainEvent = DomainAuthEvent.userUpdated;
            break;
          case supabase.AuthChangeEvent.tokenRefreshed:
            domainEvent = DomainAuthEvent.tokenRefreshed;
            break;
          default:
            domainEvent = DomainAuthEvent.unknown;
        }

        return AuthSessionState(
          event: domainEvent,
          user: user != null ? UserModel.fromSupabaseUser(user) : null,
        );
      });

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      await _client.auth.updateUser(
        supabase.UserAttributes(password: newPassword),
      );
    } on supabase.AuthException catch (e) {
      throw AuthException(e.message);
    } catch (_) {
      throw ServerException('Failed to update password.');
    }
  }

  @override
  Future<UserModel?> currentUser() async {
    final user = _client.auth.currentUser;

    if (user == null) {
      return null;
    }

    return UserModel.fromSupabaseUser(user);
  }

  @override
  Future<UserModel> googleSignIn() async {
    final googleSignIn = GoogleSignInService.googleSignIn;

    final googleUser = await googleSignIn.authenticate();

    final googleAuth = googleUser.authentication;
    final idToken = googleAuth.idToken;

    if (idToken == null) {
      throw AuthException('No ID Token found.');
    }

    try {
      final response = await _client.auth.signInWithIdToken(
        provider: supabase.OAuthProvider.google,
        idToken: idToken,
      );

      final user = response.user;
      if (user == null) {
        throw AuthException('Google Sign-In failed');
      }

      return UserModel.fromSupabaseUser(user);
    } on supabase.AuthException catch (e) {
      throw AuthException(e.message);
    } catch (_) {
      throw ServerException('Something went wrong during Google Sign-In.');
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;

      if (user == null) {
        throw AuthException('Unable to login');
      }

      return UserModel.fromSupabaseUser(user);
    } on supabase.AuthException catch (e) {
      throw AuthException(e.message);
    } on AuthException {
      rethrow;
    } catch (_) {
      throw ServerException('Something went wrong.');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _client.auth.signOut();
    } on supabase.AuthException catch (e) {
      throw AuthException(e.message);
    } catch (_) {
      throw ServerException('Unable to logout.');
    }
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'Full_name': fullName},
        emailRedirectTo: 'claritask://auth-callback',
      );

      final user = response.user;

      if (user == null) {
        throw AuthException('Registration failed');
      }

      return UserModel.fromSupabaseUser(user);
    } on supabase.AuthException catch (e) {
      throw AuthException(e.message);
    } on AuthException {
      rethrow;
    } catch (_) {
      throw ServerException('Something went wrong');
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _client.auth.resetPasswordForEmail(
        email,
        redirectTo: 'claritask://auth-callback',
      );
    } on supabase.AuthException catch (e) {
      throw AuthException(e.message);
    } catch (_) {
      throw ServerException('Unable to send reset email.');
    }
  }
}
