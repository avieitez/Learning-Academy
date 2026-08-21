import 'package:flutter/widgets.dart';

import 'mascot.dart';

class AppPreferences {
  const AppPreferences({
    required this.languageCode,
    required this.mascot,
    required this.unlockedLevels,
  });

  final String? languageCode;
  final Mascot mascot;
  final Map<String, int> unlockedLevels;

  int unlockedLevel(String area, String activity) =>
      unlockedLevels['$area/$activity'] ?? 1;

  AppPreferences copyWith({
    String? languageCode,
    Mascot? mascot,
    Map<String, int>? unlockedLevels,
  }) => AppPreferences(
    languageCode: languageCode ?? this.languageCode,
    mascot: mascot ?? this.mascot,
    unlockedLevels: unlockedLevels ?? this.unlockedLevels,
  );
}

abstract interface class AppPreferencesRepository {
  Future<AppPreferences> load();
  Future<void> save(AppPreferences preferences);
}

class AppPreferencesController extends ChangeNotifier {
  AppPreferencesController(this._repository);

  final AppPreferencesRepository _repository;
  AppPreferences _value = const AppPreferences(
    languageCode: null,
    mascot: Mascot.owl,
    unlockedLevels: {},
  );

  AppPreferences get value => _value;

  Future<void> load() async {
    _value = await _repository.load();
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) =>
      _update(_value.copyWith(languageCode: languageCode));

  Future<void> setMascot(Mascot mascot) =>
      _update(_value.copyWith(mascot: mascot));

  Future<void> unlockLevel({
    required String area,
    required String activity,
    required int level,
  }) {
    final levels = Map<String, int>.from(_value.unlockedLevels);
    final key = '$area/$activity';
    levels[key] = level > (levels[key] ?? 1) ? level : (levels[key] ?? 1);
    return _update(_value.copyWith(unlockedLevels: levels));
  }

  Future<void> _update(AppPreferences value) async {
    _value = value;
    notifyListeners();
    await _repository.save(value);
  }
}

class AppPreferencesScope extends InheritedNotifier<AppPreferencesController> {
  const AppPreferencesScope({
    required AppPreferencesController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  static AppPreferencesController of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<AppPreferencesScope>();
    assert(scope != null, 'AppPreferencesScope is missing.');
    return scope!.notifier!;
  }
}
