import 'package:flutter/material.dart';
import 'package:ruhat/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ruhat/theme_data.dart';

void main() {
  runApp( MaterialApp(
    title: 'Ruhat',
    localizationsDelegates: const [
      AppLocalizations.delegate, 
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en', ''),
      Locale('ar', ''),
    ],
    theme: ThemeClass.lightTheme,
    darkTheme: ThemeClass.darkTheme,
    home: const SplashScreen(),
  ));
}
