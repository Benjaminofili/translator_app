import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/history/presentation/screens/history_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../utils/onboarding_service.dart';

final seenOnboardingProvider = FutureProvider<bool>((ref) async {
  return await OnboardingService.hasSeenOnboarding();
});

final routerProvider = Provider<GoRouter>((ref) {
  final seenOnboarding = ref.watch(seenOnboardingProvider);

  return GoRouter(
    initialLocation: seenOnboarding.value == true ? '/home' : '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const HistoryScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});
