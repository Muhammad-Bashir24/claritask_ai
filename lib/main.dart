import 'package:claritask_ai/app/app.dart';
import 'package:claritask_ai/core/di/injection.dart';
import 'package:claritask_ai/core/services/google_sign_in_service.dart';
import 'package:claritask_ai/core/services/supabase_service.dart';
import 'package:claritask_ai/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await SupabaseService.init();
  await GoogleSignInService.init();

  await initDependencies();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => ScreenUtilInit(
        designSize: const Size(390, 844), // Example: iPhone 12
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<AuthCubit>()..checkAuthStatus()),
            ],
            child: const MyApp(),
          );
        },
      ),
    ),
  );
}
