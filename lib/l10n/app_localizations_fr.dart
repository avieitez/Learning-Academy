// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Learning Academy';

  @override
  String get tagline => 'Choisis une aventure et apprends en jouant !';

  @override
  String get mathematics => 'Mathématiques';

  @override
  String get mathematicsSubtitle => 'Nombres, additions et défis';

  @override
  String get romanNumbers => 'Chiffres romains';

  @override
  String get romanNumbersSubtitle => 'Découvre I, V, X et bien plus';

  @override
  String get clock => 'L\'horloge';

  @override
  String get clockSubtitle => 'Apprends à lire l\'heure';

  @override
  String get comingSoon => 'Bientôt disponible';

  @override
  String get comingSoonSubtitle => 'De nouvelles aventures arrivent';

  @override
  String get adSpace => 'Espace publicitaire';

  @override
  String get selectLanguage => 'Choisir la langue';

  @override
  String get back => 'Retour';

  @override
  String get featureReady =>
      'Cette aventure éducative est prête pour la prochaine étape.';
}
