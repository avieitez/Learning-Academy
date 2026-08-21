import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/app_preferences.dart';
import '../domain/mascot.dart';

class SharedPreferencesRepository implements AppPreferencesRepository {
  static const _languageKey = 'preferences.language';
  static const _mascotKey = 'preferences.mascot';
  static const _progressKey = 'progress.unlocked_levels';

  @override
  Future<AppPreferences> load() async {
    final preferences = await SharedPreferences.getInstance();
    final progressJson = preferences.getString(_progressKey);
    final progress = progressJson == null
        ? <String, int>{}
        : (jsonDecode(progressJson) as Map<String, dynamic>).map(
            (key, value) => MapEntry(key, value as int),
          );
    return AppPreferences(
      languageCode: preferences.getString(_languageKey),
      mascot: Mascot.fromId(preferences.getString(_mascotKey)),
      unlockedLevels: progress,
    );
  }

  @override
  Future<void> save(AppPreferences value) async {
    final preferences = await SharedPreferences.getInstance();
    if (value.languageCode != null) {
      await preferences.setString(_languageKey, value.languageCode!);
    }
    await preferences.setString(_mascotKey, value.mascot.id);
    await preferences.setString(_progressKey, jsonEncode(value.unlockedLevels));
  }
}
