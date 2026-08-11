import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? fullName;
  final String? avatarUrl;
  final bool emailVerified;
  final String provider;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.email,
    this.fullName,
    this.avatarUrl,
    required this.emailVerified,
    required this.provider,
    required this.createdAt,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    email,
    fullName,
    avatarUrl,
    emailVerified,
    provider,
    createdAt,
  ];
}
