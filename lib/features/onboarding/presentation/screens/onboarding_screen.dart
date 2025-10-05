import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/onboarding_service.dart';
import '../../../../core/utils/permission_service.dart';
import '../widgets/tutorial_carousel.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _isLastPage = false;
  bool _isLoading = false;

  // In onboarding_screen.dart, update _completeOnboarding:
  Future<void> _completeOnboarding() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final permissionGranted = await PermissionService.requestMicrophone();

      if (!permissionGranted && mounted) {
        _showPermissionDialog();
        setState(() => _isLoading = false);
        return;
      }

      await OnboardingService.setSeenOnboarding();

      if (mounted) {
        // Use this instead of context.go('/home')
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Microphone Permission Required'),
        content: const Text(
          'This app needs microphone access to translate your voice. '
              'Please grant permission in settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              PermissionService.openSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  Future<void> _skipOnboarding() async {
    await OnboardingService.setSeenOnboarding();
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (!_isLastPage)
            TextButton(
              onPressed: _skipOnboarding,
              child: const Text(
                'Skip',
                style: TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          TutorialCarousel(
            onLastPageChanged: (isLastPage) {
              setState(() => _isLastPage = isLastPage);
            },
            onFinished: _completeOnboarding,
          ),
          if (_isLoading)
            Container(
              color: Colors.black26,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}