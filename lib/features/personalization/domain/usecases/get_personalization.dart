import 'package:claritask_ai/core/utils/typedefs.dart';
import 'package:claritask_ai/features/personalization/domain/entities/personalization.dart';
import 'package:claritask_ai/features/personalization/domain/repositories/personalization_repository.dart';

class GetPersonalizationUseCase {
  final PersonalizationRepository _repository;

  GetPersonalizationUseCase(this._repository);

  ResultFuture<PersonalizationEntity?> call([void params]) async {
    return await _repository.getPersonalization();
  }
}
