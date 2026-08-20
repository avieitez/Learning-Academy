import '../domain/math_level.dart';
import '../domain/math_operation.dart';

abstract final class MathematicsCatalog {
  static const operations = MathOperation.values;
  static const levelCount = 12;

  static List<MathLevel> levels({int currentLevel = 1}) {
    assert(currentLevel >= 1 && currentLevel <= levelCount);
    return List.generate(levelCount, (index) {
      final number = index + 1;
      if (number < currentLevel) {
        return MathLevel(
          number: number,
          status: MathLevelStatus.completed,
          stars: 3,
        );
      }
      if (number == currentLevel) {
        return MathLevel(
          number: number,
          status: MathLevelStatus.available,
          stars: 0,
        );
      }
      return MathLevel(
        number: number,
        status: MathLevelStatus.locked,
        stars: 0,
      );
    });
  }
}
