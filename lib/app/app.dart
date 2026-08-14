import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'routes.dart';
import 'theme.dart';

class LearningAcademyApp extends StatefulWidget {
  const LearningAcademyApp({super.key});

  @override
  State<LearningAcademyApp> createState() => _LearningAcademyAppState();
}

class _LearningAcademyAppState extends State<LearningAcademyApp> {
  Locale? _locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning Academy',
      debugShowCheckedModeBanner: false,
      theme: LearningAcademyTheme.light,
      locale: _locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateRoute: (settings) => AppRoutes.onGenerateRoute(
        settings,
        onLocaleChanged: (locale) => setState(() => _locale = locale),
      ),
      initialRoute: AppRoutes.home,
    );
  }
}
