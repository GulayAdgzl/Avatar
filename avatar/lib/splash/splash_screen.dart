import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:avatar/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Padding(
              
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Lottie.asset(
                  'assets/animation/Animation - 1735902222159.json',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
      nextScreen: HomePage(),
      splashIconSize: double.infinity,
      backgroundColor: Colors.white, // Adjust color as needed
    );
  }
}