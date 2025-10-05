import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
        widget.onLastPageChanged?.call(newIndex == 3); // 4 pages total (0-3)
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
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
            children: const [
              // Page 1: Welcome Animation
              WelcomeAnimation(),

              // Page 2: Language Selection
              LanguageSelector(),

              // Page 3: Permission Request
              PermissionCard(),

              // Page 4: Final Info
              Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mic, size: 100, color: Colors.blue),
                      SizedBox(height: 30),
                      Text(
                        "You're All Set!",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Tap the microphone to start translating your voice in real-time.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Page Indicator
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SmoothPageIndicator(
            controller: _controller,
            count: 4,
            effect: ExpandingDotsEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: Theme.of(context).primaryColor,
              dotColor: Colors.grey.shade400,
            ),
          ),
        ),

        // Navigation Buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button (hidden on first page)
              if (_currentIndex > 0)
                TextButton.icon(
                  onPressed: _previousPage,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                )
              else
                const SizedBox(width: 80), // Placeholder for spacing

              // Next/Get Started Button
              if (_currentIndex < 3)
                ElevatedButton.icon(
                  onPressed: _nextPage,
                  label: const Text('Next'),
                  // icon: const Icon(Icons.arrow_forward),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                )
              else
                ElevatedButton(
                  onPressed: widget.onFinished,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 40),
      ],
    );
  }
}