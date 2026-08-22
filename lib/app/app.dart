import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../settings/data/shared_preferences_repository.dart';
import '../settings/domain/app_preferences.dart';
import 'routes.dart';
import 'theme.dart';

class LearningAcademyApp extends StatefulWidget {
  const LearningAcademyApp({this.preferencesController, super.key});

  final AppPreferencesController? preferencesController;

  @override
  State<LearningAcademyApp> createState() => _LearningAcademyAppState();
}

class _LearningAcademyAppState extends State<LearningAcademyApp> {
  late final AppPreferencesController _preferencesController;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.preferencesController == null;
    _preferencesController =
        widget.preferencesController ??
        AppPreferencesController(SharedPreferencesRepository());
    _preferencesController.addListener(_onPreferencesChanged);
    if (_ownsController) _preferencesController.load();
  }

  void _onPreferencesChanged() => setState(() {});

  @override
  void dispose() {
    _preferencesController.removeListener(_onPreferencesChanged);
    if (_ownsController) _preferencesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = _preferencesController.value.languageCode;
    return AppPreferencesScope(
      controller: _preferencesController,
      child: MaterialApp(
        title: 'Learning Academy',
        debugShowCheckedModeBanner: false,
        theme: LearningAcademyTheme.light,
        locale: Locale(languageCode),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: AppRoutes.home,
      ),
    );
  }
}
