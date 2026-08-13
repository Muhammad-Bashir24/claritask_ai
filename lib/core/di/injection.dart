import 'package:claritask_ai/core/network/network_info.dart';
import 'package:claritask_ai/core/network/network_info_impl.dart';
import 'package:claritask_ai/core/services/supabase_service.dart';
import 'package:claritask_ai/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:claritask_ai/features/authentication/data/datasources/auth_remote_datasource_impl.dart';
import 'package:claritask_ai/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:claritask_ai/features/authentication/domain/repositories/auth_repository.dart';
import 'package:claritask_ai/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:claritask_ai/features/personalization/data/datasources/personalization_remote_datasource.dart';
import 'package:claritask_ai/features/personalization/data/repositories/personalization_repository_impl.dart';
import 'package:claritask_ai/features/personalization/domain/repositories/personalization_repository.dart';
import 'package:claritask_ai/features/personalization/domain/usecases/check_onboarding_status.dart';
import 'package:claritask_ai/features/personalization/domain/usecases/save_personalization.dart';
import 'package:claritask_ai/features/personalization/presentation/cubit/personalization_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Supabase
  sl.registerLazySingleton(() => SupabaseService.client);

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(InternetConnection()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<PersonalizationRemoteDataSource>(
    () => PersonalizationRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<PersonalizationRepository>(
    () => PersonalizationRepositoryImpl(sl(), sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => SavePersonalizationUseCase(sl()));
  sl.registerLazySingleton(() => CheckOnboardingStatusUseCase(sl()));

  // Cubits
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerFactory(() => PersonalizationCubit(sl()));
}
