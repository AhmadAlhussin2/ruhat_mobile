import 'package:flutter/material.dart';
import 'package:ruhat/starting_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor!,
        duration: 1500,
        splash: Text(
          "Ruhat",
          style: TextStyle(
            fontSize: 50,
            fontFamily: 'shago',
            color: Theme.of(context).focusColor,
          ),
        ),
        nextScreen: EnterQuiz(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
