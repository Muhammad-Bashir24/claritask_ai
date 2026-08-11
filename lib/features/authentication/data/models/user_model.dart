import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.fullName,
    super.avatarUrl,
    required super.emailVerified,
    required super.provider,
    required super.createdAt,
  });

  /// Creates a UserModel from Supabase Auth User
  factory UserModel.fromSupabaseUser(User user) {
    final metadata = user.userMetadata ?? {};
    final appMetadata = user.appMetadata;

    return UserModel(
      id: user.id,
      email: user.email ?? '',
      fullName: metadata['full_name'] as String?,
      avatarUrl: metadata['avatar_url'] as String?,
      emailVerified: user.emailConfirmedAt != null,
      provider: appMetadata['provider']?.toString() ?? 'email',
      createdAt: DateTime.parse(user.createdAt),
    );
  }

  /// Creates a UserModel from database JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      emailVerified: json['email_verified'] as bool? ?? false,
      provider: json['provider'] as String? ?? 'email',
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  /// Converts model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'email_verified': emailVerified,
      'provider': provider,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Creates a copy with updated values
  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? avatarUrl,
    bool? emailVerified,
    String? provider,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      emailVerified: emailVerified ?? this.emailVerified,
      provider: provider ?? this.provider,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
