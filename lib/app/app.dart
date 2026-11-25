import 'package:claritask_ai/app/router.dart';
import 'package:claritask_ai/app/theme/app_theme.dart';
import 'package:claritask_ai/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.createRouter(context.read<AuthCubit>().stream);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ClariTask AI',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: AppTheme.light,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
    );
  }
}
