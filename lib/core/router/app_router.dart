import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../utils/onboarding_service.dart';

// Provider for onboarding status
final seenOnboardingProvider = FutureProvider<bool>((ref) async {
  return await OnboardingService.hasSeenOnboarding();
});

// Router provider
final routerProvider = Provider<GoRouter>((ref) {
  final seenOnboarding = ref.watch(seenOnboardingProvider);

  return GoRouter(
    initialLocation: seenOnboarding.value == true ? '/home' : '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) =>  OnboardingScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) =>  HomeScreen(),
      ),
    ],
    redirect: (context, state) {
      // Optional: Add redirect logic if needed
      return null;
    },
  );
});