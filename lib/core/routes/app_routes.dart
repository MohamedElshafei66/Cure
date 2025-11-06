import 'package:go_router/go_router.dart';

import '../../feature/onboarding/presentation/onboarding_screen.dart';

abstract class AppRoutes {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => OnboardingScreen()),
    ],
  );
}
