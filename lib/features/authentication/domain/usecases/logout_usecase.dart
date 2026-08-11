import 'package:claritask_ai/core/utils/typedefs.dart';
import 'package:claritask_ai/features/authentication/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository repository;

  LogoutUsecase(this.repository);

  ResultFuture<void> call() {
    return repository.logout();
  }
}
