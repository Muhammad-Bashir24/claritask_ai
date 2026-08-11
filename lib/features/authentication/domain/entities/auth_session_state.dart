import 'package:claritask_ai/features/authentication/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

enum DomainAuthEvent {
  initialSession,
  signedIn,
  signedOut,
  passwordRecovery,
  userUpdated,
  tokenRefreshed,
  unknown
}

class AuthSessionState extends Equatable {
  final DomainAuthEvent event;
  final UserEntity? user;

  const AuthSessionState({
    required this.event,
    this.user,
  });

  @override
  List<Object?> get props => [event, user];
}
