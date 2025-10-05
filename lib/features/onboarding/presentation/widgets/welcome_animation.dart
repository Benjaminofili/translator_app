import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeAnimation extends StatelessWidget {
  const WelcomeAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/animations/welcome.json", height: 200),
          const SizedBox(height: 20),
          const Text(
            "Welcome to Translator App",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "Your personal voice & text translator",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
