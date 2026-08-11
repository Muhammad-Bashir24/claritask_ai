import 'package:claritask_ai/core/network/network_info.dart';
import 'package:claritask_ai/core/network/network_info_impl.dart';
import 'package:claritask_ai/core/services/supabase_service.dart';
import 'package:claritask_ai/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:claritask_ai/features/authentication/data/datasources/auth_remote_datasource_impl.dart';
import 'package:claritask_ai/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:claritask_ai/features/authentication/domain/repositories/auth_repository.dart';
import 'package:claritask_ai/features/authentication/presentation/cubit/auth_cubit.dart';
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

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  // Cubits
  sl.registerFactory(() => AuthCubit(sl()));
}
