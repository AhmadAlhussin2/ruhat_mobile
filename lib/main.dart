import 'package:flutter/material.dart';
import 'package:ruhat/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main() {
  runApp(const MaterialApp(
    title: 'Ruhat',
    localizationsDelegates: [
      AppLocalizations.delegate, 
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      Locale('en', ''),
      Locale('ar', ''),
    ],
    home: SplashScreen(),
  ));
}
