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
import 'package:claritask_ai/features/home/presentation/cubit/home_cubit.dart';
import 'package:claritask_ai/features/personalization/domain/usecases/get_personalization.dart';
import 'package:claritask_ai/features/personalization/presentation/cubit/personalization_cubit.dart';
import 'package:claritask_ai/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:claritask_ai/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:claritask_ai/features/tasks/domain/repositories/task_repository.dart';
import 'package:claritask_ai/features/tasks/domain/usecases/create_task.dart';
import 'package:claritask_ai/features/tasks/presentation/cubit/create_task_cubit.dart';
import 'package:claritask_ai/features/task_breakdown/data/datasources/task_breakdown_remote_datasource.dart';
import 'package:claritask_ai/features/task_breakdown/data/repositories/task_breakdown_repository_impl.dart';
import 'package:claritask_ai/features/task_breakdown/domain/repositories/task_breakdown_repository.dart';
import 'package:claritask_ai/features/task_breakdown/domain/usecases/breakdown_task.dart';
import 'package:claritask_ai/features/task_breakdown/domain/usecases/get_task_steps.dart';
import 'package:claritask_ai/features/task_breakdown/domain/usecases/update_task_step.dart';
import 'package:claritask_ai/features/task_breakdown/presentation/cubit/task_breakdown_cubit.dart';
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
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<TaskBreakdownRemoteDataSource>(
    () => TaskBreakdownRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<PersonalizationRepository>(
    () => PersonalizationRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));
  sl.registerLazySingleton<TaskBreakdownRepository>(
    () => TaskBreakdownRepositoryImpl(sl(), sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => SavePersonalizationUseCase(sl()));
  sl.registerLazySingleton(() => CheckOnboardingStatusUseCase(sl()));
  sl.registerLazySingleton(() => GetPersonalizationUseCase(sl()));
  sl.registerLazySingleton(() => CreateTaskUseCase(sl()));
  sl.registerLazySingleton(() => BreakdownTaskUseCase(sl()));
  sl.registerLazySingleton(() => GetTaskStepsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTaskStepUseCase(sl()));

  // Cubits
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerFactory(() => PersonalizationCubit(sl()));
  sl.registerFactory(() => HomeCubit(sl()));
  sl.registerFactory(() => CreateTaskCubit(sl()));
  sl.registerFactory(() => TaskBreakdownCubit(sl(), sl(), sl()));
}
