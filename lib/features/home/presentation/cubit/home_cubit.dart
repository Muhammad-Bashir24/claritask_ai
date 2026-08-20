import 'package:claritask_ai/features/personalization/domain/entities/personalization.dart';
import 'package:claritask_ai/features/personalization/domain/usecases/get_personalization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetPersonalizationUseCase _getPersonalizationUseCase;

  HomeCubit(this._getPersonalizationUseCase) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    final result = await _getPersonalizationUseCase();

    result.fold((failure) => emit(HomeError(failure.message)), (
      personalization,
    ) {
      if (personalization != null) {
        emit(HomeLoaded(personalization));
      } else {
        // If null, it means no personalization found, which is a fallback state
        emit(const HomeError('No personalization found.'));
      }
    });
  }
}
