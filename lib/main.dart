import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'settings/data/shared_preferences_repository.dart';
import 'settings/domain/app_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = AppPreferencesController(SharedPreferencesRepository());
  await preferences.load();
  runApp(LearningAcademyApp(preferencesController: preferences));
}
