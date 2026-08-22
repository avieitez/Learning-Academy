import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Learning Academy'**
  String get appTitle;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Choose an adventure and learn while playing!'**
  String get tagline;

  /// No description provided for @mathematics.
  ///
  /// In en, this message translates to:
  /// **'Mathematics'**
  String get mathematics;

  /// No description provided for @mathematicsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Numbers, sums and challenges'**
  String get mathematicsSubtitle;

  /// No description provided for @romanNumbers.
  ///
  /// In en, this message translates to:
  /// **'Roman Numbers'**
  String get romanNumbers;

  /// No description provided for @romanNumbersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discover I, V, X and more'**
  String get romanNumbersSubtitle;

  /// No description provided for @clock.
  ///
  /// In en, this message translates to:
  /// **'Clock'**
  String get clock;

  /// No description provided for @clockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learn to tell the time'**
  String get clockSubtitle;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @comingSoonSubtitle.
  ///
  /// In en, this message translates to:
  /// **'New adventures are on the way'**
  String get comingSoonSubtitle;

  /// No description provided for @adSpace.
  ///
  /// In en, this message translates to:
  /// **'Ad space'**
  String get adSpace;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get selectLanguage;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @featureReady.
  ///
  /// In en, this message translates to:
  /// **'This learning adventure is ready for its next stage.'**
  String get featureReady;

  /// No description provided for @chooseOperation.
  ///
  /// In en, this message translates to:
  /// **'Choose an operation'**
  String get chooseOperation;

  /// No description provided for @addition.
  ///
  /// In en, this message translates to:
  /// **'Addition'**
  String get addition;

  /// No description provided for @additionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learn to add while playing'**
  String get additionSubtitle;

  /// No description provided for @subtraction.
  ///
  /// In en, this message translates to:
  /// **'Subtraction'**
  String get subtraction;

  /// No description provided for @subtractionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find the differences'**
  String get subtractionSubtitle;

  /// No description provided for @multiplication.
  ///
  /// In en, this message translates to:
  /// **'Multiplication'**
  String get multiplication;

  /// No description provided for @multiplicationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Challenge your mind'**
  String get multiplicationSubtitle;

  /// No description provided for @division.
  ///
  /// In en, this message translates to:
  /// **'Division'**
  String get division;

  /// No description provided for @divisionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Divide and conquer'**
  String get divisionSubtitle;

  /// No description provided for @levelMap.
  ///
  /// In en, this message translates to:
  /// **'Level Map'**
  String get levelMap;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @exercisesComingNext.
  ///
  /// In en, this message translates to:
  /// **'The exercise session is the next development stage.'**
  String get exercisesComingNext;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @chooseMascot.
  ///
  /// In en, this message translates to:
  /// **'Choose your mascot'**
  String get chooseMascot;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About Learning Academy'**
  String get about;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'A safe and playful learning app designed to help children progress at their own pace.'**
  String get aboutDescription;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact and support'**
  String get contactSupport;

  /// No description provided for @owl.
  ///
  /// In en, this message translates to:
  /// **'Owl'**
  String get owl;

  /// No description provided for @fox.
  ///
  /// In en, this message translates to:
  /// **'Fox'**
  String get fox;

  /// No description provided for @panda.
  ///
  /// In en, this message translates to:
  /// **'Panda'**
  String get panda;

  /// No description provided for @lion.
  ///
  /// In en, this message translates to:
  /// **'Lion'**
  String get lion;

  /// No description provided for @bunny.
  ///
  /// In en, this message translates to:
  /// **'Bunny'**
  String get bunny;

  /// No description provided for @unicorn.
  ///
  /// In en, this message translates to:
  /// **'Unicorn'**
  String get unicorn;

  /// No description provided for @additionLevelOne.
  ///
  /// In en, this message translates to:
  /// **'Addition · Level 1'**
  String get additionLevelOne;

  /// No description provided for @howManyAltogether.
  ///
  /// In en, this message translates to:
  /// **'How many are there altogether?'**
  String get howManyAltogether;

  /// No description provided for @chooseAnAnswer.
  ///
  /// In en, this message translates to:
  /// **'Choose an answer!'**
  String get chooseAnAnswer;

  /// No description provided for @correctAnswer.
  ///
  /// In en, this message translates to:
  /// **'Great! That\'s correct!'**
  String get correctAnswer;

  /// No description provided for @keepTrying.
  ///
  /// In en, this message translates to:
  /// **'Nice try! Let\'s continue.'**
  String get keepTrying;

  /// No description provided for @greatJob.
  ///
  /// In en, this message translates to:
  /// **'Great job!'**
  String get greatJob;

  /// No description provided for @goodTry.
  ///
  /// In en, this message translates to:
  /// **'Good try!'**
  String get goodTry;

  /// No description provided for @returnToMap.
  ///
  /// In en, this message translates to:
  /// **'Return to map'**
  String get returnToMap;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
