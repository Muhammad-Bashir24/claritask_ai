import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:claritask_ai/features/authentication/domain/entities/auth_session_state.dart';
import 'package:claritask_ai/features/authentication/domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription? _authSubscription;

  AuthCubit(this._authRepository) : super(AuthInitial()) {
    _authSubscription = _authRepository.authStateChanges.listen((state) {
      if (state.event == DomainAuthEvent.passwordRecovery) {
        emit(AuthPasswordRecovery());
      } else if (state.user != null) {
        emit(AuthAuthenticated(state.user));
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    final result = await _authRepository.currentUser();
    result.fold((failure) => emit(AuthUnauthenticated()), (user) {
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }

  Future<void> loginWithEmail(String email, String password) async {
    emit(AuthLoading());
    final result = await _authRepository.login(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> register(String email, String password, String fullName) async {
    emit(AuthLoading());
    final result = await _authRepository.register(
      email: email,
      password: password,
      fullName: fullName,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthVerificationEmailSent()),
    );
  }

  Future<void> loginWithGoogle() async {
    emit(AuthLoading());
    final result = await _authRepository.googleSignIn();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    final result = await _authRepository.resetPassword(email: email);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthPasswordResetEmailSent()),
    );
  }

  Future<void> updatePassword(String newPassword) async {
    emit(AuthLoading());
    final result = await _authRepository.updatePassword(newPassword);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthPasswordUpdated()),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final result = await _authRepository.logout();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthUnauthenticated()),
    );
  }
}
