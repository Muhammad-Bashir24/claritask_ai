import 'package:claritask_ai/core/utils/typedefs.dart';
import 'package:claritask_ai/features/authentication/domain/entities/user_entity.dart';
import 'package:claritask_ai/features/authentication/domain/repositories/auth_repository.dart';

class GoogleSignInUsecase {
  final AuthRepository repository;

  GoogleSignInUsecase(this.repository);

  ResultFuture<UserEntity> call() {
    return repository.googleSignIn();
  }
}
