import 'package:claritask_ai/core/utils/typedefs.dart';
import 'package:claritask_ai/features/personalization/domain/entities/personalization.dart';
import 'package:claritask_ai/features/personalization/domain/repositories/personalization_repository.dart';

class SavePersonalizationUseCase {
  final PersonalizationRepository _repository;

  SavePersonalizationUseCase(this._repository);

  ResultVoid call(PersonalizationEntity personalization) {
    return _repository.savePersonalization(personalization);
  }
}
