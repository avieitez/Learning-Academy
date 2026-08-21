import 'package:flutter_test/flutter_test.dart';
import 'package:learning_academy/settings/data/shared_preferences_repository.dart';
import 'package:learning_academy/settings/domain/app_preferences.dart';
import 'package:learning_academy/settings/domain/mascot.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('persists language, mascot and independent activity progress', () async {
    final repository = SharedPreferencesRepository();
    final controller = AppPreferencesController(repository);
    await controller.load();

    await controller.setLanguage('es');
    await controller.setMascot(Mascot.fox);
    await controller.unlockLevel(
      area: 'mathematics',
      activity: 'addition',
      level: 5,
    );
    await controller.unlockLevel(
      area: 'mathematics',
      activity: 'division',
      level: 3,
    );
    await controller.unlockLevel(
      area: 'roman_numbers',
      activity: 'roman_to_number',
      level: 7,
    );

    final stored = await repository.load();
    expect(stored.languageCode, 'es');
    expect(stored.mascot.id, 'fox');
    expect(stored.unlockedLevel('mathematics', 'addition'), 5);
    expect(stored.unlockedLevel('mathematics', 'division'), 3);
    expect(stored.unlockedLevel('roman_numbers', 'roman_to_number'), 7);
    expect(stored.unlockedLevel('clock', 'read_clock'), 1);
  });

  test('never reduces an already unlocked level', () async {
    final controller = AppPreferencesController(SharedPreferencesRepository());
    await controller.load();
    await controller.unlockLevel(
      area: 'mathematics',
      activity: 'addition',
      level: 6,
    );
    await controller.unlockLevel(
      area: 'mathematics',
      activity: 'addition',
      level: 2,
    );
    expect(controller.value.unlockedLevel('mathematics', 'addition'), 6);
  });
}
