import 'package:claritask_ai/core/utils/typedefs.dart';
import 'package:claritask_ai/features/personalization/domain/entities/personalization.dart';

abstract interface class PersonalizationRepository {
  ResultVoid savePersonalization(PersonalizationEntity personalization);
  ResultFuture<bool> checkOnboardingCompleted();
  ResultFuture<PersonalizationEntity?> getPersonalization();
}
