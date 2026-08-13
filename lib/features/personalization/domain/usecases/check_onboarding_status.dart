import 'package:claritask_ai/core/utils/typedefs.dart';
import 'package:claritask_ai/features/personalization/domain/repositories/personalization_repository.dart';

class CheckOnboardingStatusUseCase {
  final PersonalizationRepository _repository;

  CheckOnboardingStatusUseCase(this._repository);

  ResultFuture<bool> call() {
    return _repository.checkOnboardingCompleted();
  }
}
