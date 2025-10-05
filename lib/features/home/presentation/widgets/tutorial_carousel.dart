import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

  final List<String> _pages = [
    "Welcome to AI Voice Translator!",
    "Select your languages easily.",
    "Grant microphone permission for live translations.",
    "Swipe to translate in real-time!",
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final newIndex = _controller.page?.round() ?? 0;
      if (newIndex != _currentIndex) {
        setState(() => _currentIndex = newIndex);
        widget.onLastPageChanged?.call(newIndex == _pages.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (_, index) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  _pages[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
        ),

        // 🔹 Smooth Page Indicator
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: SmoothPageIndicator(
            controller: _controller,
            count: _pages.length,
            effect: ExpandingDotsEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: Theme.of(context).primaryColor,
              dotColor: Colors.grey.shade400,
            ),
          ),
        ),

        // 🔹 Show button only on last page
        if (_currentIndex == _pages.length - 1)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: widget.onFinished,
              child: const Text("Get Started"),
            ),
          ),
      ],
    );
  }
}
