import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../progress/domain/exercise_session.dart';
import '../domain/app_preferences.dart';
import '../domain/mascot.dart';

class SharedPreferencesRepository implements AppPreferencesRepository {
  static const _languageKey = 'preferences.language';
  static const _mascotKey = 'preferences.mascot';
  static const _progressKey = 'progress.unlocked_levels';
  static const _sessionsKey = 'progress.active_sessions';

  @override
  Future<AppPreferences> load() async {
    final preferences = await SharedPreferences.getInstance();
    final progressJson = preferences.getString(_progressKey);
    final progress = progressJson == null
        ? <String, int>{}
        : (jsonDecode(progressJson) as Map<String, dynamic>).map(
            (key, value) => MapEntry(key, value as int),
          );
    final sessionsJson = preferences.getString(_sessionsKey);
    final sessions = sessionsJson == null
        ? <String, ExerciseSession>{}
        : (jsonDecode(sessionsJson) as Map<String, dynamic>).map(
            (key, value) => MapEntry(
              key,
              ExerciseSession.fromJson(value as Map<String, dynamic>),
            ),
          );
    return AppPreferences(
      languageCode: preferences.getString(_languageKey) ?? 'en',
      mascot: Mascot.fromId(preferences.getString(_mascotKey)),
      unlockedLevels: progress,
      activeSessions: sessions,
    );
  }

  @override
  Future<void> save(AppPreferences value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_languageKey, value.languageCode);
    await preferences.setString(_mascotKey, value.mascot.id);
    await preferences.setString(_progressKey, jsonEncode(value.unlockedLevels));
    await preferences.setString(
      _sessionsKey,
      jsonEncode(
        value.activeSessions.map((key, value) => MapEntry(key, value.toJson())),
      ),
    );
  }

  @override
  Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_languageKey);
    await preferences.remove(_mascotKey);
    await preferences.remove(_progressKey);
    await preferences.remove(_sessionsKey);
  }
}
