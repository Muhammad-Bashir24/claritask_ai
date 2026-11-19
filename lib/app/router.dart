import 'package:claritask_ai/features/authentication/presentation/screens/auth_screen.dart';
import 'package:claritask_ai/features/authentication/presentation/screens/forgot_password_screen.dart';
import 'package:claritask_ai/features/authentication/presentation/screens/signup_screen.dart';
import 'package:claritask_ai/features/authentication/presentation/screens/update_password_screen.dart';
import 'package:claritask_ai/features/home/presentation/screens/home_screen.dart';
import 'package:claritask_ai/features/landing/presentation/screens/landing_screen.dart';
import 'package:claritask_ai/features/marketing_onbaording/presentation/screens/marketing_onboarding_sreens.dart';
import 'package:claritask_ai/features/personalization/presentation/cubit/personalization_cubit.dart';
import 'package:claritask_ai/features/personalization/presentation/pages/personalization_page.dart';
import 'package:claritask_ai/features/splash/presentation/screens/splash_screen.dart';
import 'package:claritask_ai/features/tasks/presentation/pages/create_task_page.dart';
import 'package:claritask_ai/features/task_breakdown/presentation/pages/task_workspace_page.dart';
import 'package:claritask_ai/core/di/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AppRouter {
  static GoRouter createRouter(Stream<dynamic> authStateStream) {
    return GoRouter(
      initialLocation: kIsWeb ? '/landing' : '/splash',
      refreshListenable: GoRouterRefreshStream(authStateStream),
      routes: [
        GoRoute(
          path: '/',
          name: 'root',
          redirect: (context, state) {
            if (kIsWeb) {
              return '/landing';
            } else {
              return '/splash';
            }
          },
        ),
        GoRoute(
          path: '/landing',
          name: 'landing',
          redirect: (context, state) {
            // Landing page is ONLY accessible on web platforms!
            if (!kIsWeb) {
              return '/splash';
            }
            return null;
          },
          builder: (context, state) => const LandingScreen(),
        ),
        GoRoute(
          path: '/splash',
          name: 'splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          name: 'onboarding',
          builder: (context, state) => const MarketingOnboardingScreens(),
        ),
        GoRoute(
          path: '/auth',
          name: 'auth',
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: '/signup',
          name: 'signup',
          builder: (context, state) => const SignupScreen(),
        ),
        GoRoute(
          path: '/forgot-password',
          name: 'forgot-password',
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/personalization',
          name: 'personalization',
          builder: (context, state) => BlocProvider(
            create: (context) => sl<PersonalizationCubit>(),
            child: const PersonalizationPage(),
          ),
        ),
        GoRoute(
          path: '/update-password',
          name: 'update-password',
          builder: (context, state) => const UpdatePasswordScreen(),
        ),
        GoRoute(
          path: '/create-task',
          name: 'create-task',
          builder: (context, state) {
            final primaryUsage = state.extra as String? ?? '';
            return CreateTaskPage(primaryUsage: primaryUsage);
          },
        ),
        GoRoute(
          path: '/task-workspace',
          name: 'task-workspace',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            final taskId = extra?['taskId'] as String? ?? '';
            final taskTitle = extra?['taskTitle'] as String? ?? '';
            return TaskWorkspacePage(taskId: taskId, taskTitle: taskTitle);
          },
        ),
      ],
      redirect: (context, state) {
        final location = state.uri.toString();
        // Intercept deep links from Supabase to prevent "no routes for location" error
        if (location.contains('auth-callback') || location.contains('code=')) {
          return '/splash';
        }
        // Ensure landing page is strictly inaccessible on native platforms
        if (!kIsWeb && (location == '/' || location.startsWith('/landing'))) {
          return '/splash';
        }
        // Redirect web root to landing page
        if (kIsWeb && location == '/') {
          return '/landing';
        }
        return null;
      },
    );
  }
}
