part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthAuthenticated extends AuthState {
  final dynamic user; // Using dynamic or importing UserEntity. Let's import UserEntity in the cubit.

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

final class AuthUnauthenticated extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

final class AuthPasswordResetEmailSent extends AuthState {}

final class AuthVerificationEmailSent extends AuthState {}

final class AuthPasswordRecovery extends AuthState {}

final class AuthPasswordUpdated extends AuthState {}
