import 'package:claritask_ai/core/utils/typedefs.dart';
import 'package:claritask_ai/features/authentication/domain/entities/user_entity.dart';
import 'package:claritask_ai/features/authentication/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  ResultFuture<UserEntity> call({
    required String email,
    required String fullName,
    required String password,
  }) {
    return repository.register(
      email: email,
      password: password,
      fullName: fullName,
    );
  }
}
