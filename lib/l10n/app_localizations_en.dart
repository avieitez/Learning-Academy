// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Learning Academy';

  @override
  String get tagline => 'Choose an adventure and learn while playing!';

  @override
  String get mathematics => 'Mathematics';

  @override
  String get mathematicsSubtitle => 'Numbers, sums and challenges';

  @override
  String get romanNumbers => 'Roman Numbers';

  @override
  String get romanNumbersSubtitle => 'Discover I, V, X and more';

  @override
  String get clock => 'Clock';

  @override
  String get clockSubtitle => 'Learn to tell the time';

  @override
  String get comingSoon => 'Coming Soon';

  @override
  String get comingSoonSubtitle => 'New adventures are on the way';

  @override
  String get adSpace => 'Ad space';

  @override
  String get selectLanguage => 'Choose language';

  @override
  String get back => 'Back';

  @override
  String get featureReady =>
      'This learning adventure is ready for its next stage.';
}
