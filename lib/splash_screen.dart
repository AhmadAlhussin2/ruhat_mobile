import 'package:flutter/material.dart';
import 'package:ruhat/starting_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        backgroundColor: const Color.fromRGBO(221, 226, 232, 1),
        duration: 1500,
        splash: const Text(
          "Ruhat",
          style: TextStyle(
            fontSize: 50,
            fontFamily: 'shago',
            color: Color.fromRGBO(0, 95, 117, 1),
          ),
        ),
        nextScreen: const EnterQuiz(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
