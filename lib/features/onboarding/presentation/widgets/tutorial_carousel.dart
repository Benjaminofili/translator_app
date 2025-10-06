import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_colors.dart';
import 'welcome_animation.dart';
import 'language_selector.dart';
import 'permission_card.dart';

class TutorialCarousel extends StatefulWidget {
  final void Function(bool isLastPage)? onLastPageChanged;
  final VoidCallback onFinished;

  const TutorialCarousel({
    super.key,
    required this.onFinished,
    this.onLastPageChanged,
  });

  @override
  State<TutorialCarousel> createState() => _TutorialCarouselState();
}

class _TutorialCarouselState extends State<TutorialCarousel> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final newIndex = _controller.page?.round() ?? 0;
      if (newIndex != _currentIndex) {
        setState(() => _currentIndex = newIndex);
        widget.onLastPageChanged?.call(newIndex == 3);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < 3) {
      _controller.nextPage(
        duration: AppTheme.durationMedium,
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _controller.previousPage(
        duration: AppTheme.durationMedium,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _controller,
            children: [
              const WelcomeAnimation(),
              const LanguageSelector(),
              const PermissionCard(),

              // Page 4: Final Info - Updated with theme
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingLg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mic_rounded,
                        size: 100,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: AppTheme.spacingXl),
                      Text(
                        "You're All Set!",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: AppTheme.spacingMd),
                      Text(
                        "Tap the microphone to start translating your voice in real-time.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.spacingMd),
          child: SmoothPageIndicator(
            controller: _controller,
            count: 4,
            effect: ExpandingDotsEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: AppColors.primary,
              dotColor: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentIndex > 0)
                TextButton.icon(
                  onPressed: _previousPage,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                )
              else
                const SizedBox(width: 80),

              if (_currentIndex < 3)
                ElevatedButton(
                  onPressed: _nextPage,
                  child: const Text('Next'),
                )
              else
                ElevatedButton(
                  onPressed: widget.onFinished,
                  child: const Text('Get Started'),
                ),
            ],
          ),
        ),

        const SizedBox(height: AppTheme.spacingXl),
      ],
    );
  }
}