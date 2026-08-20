import 'package:flutter_test/flutter_test.dart';
import 'package:learning_academy/features/mathematics/data/mathematics_catalog.dart';
import 'package:learning_academy/features/mathematics/domain/math_level.dart';

void main() {
  test('catalog creates twelve sequential levels', () {
    final levels = MathematicsCatalog.levels(currentLevel: 4);

    expect(levels, hasLength(12));
    expect(levels.first.number, 1);
    expect(levels.last.number, 12);
    expect(levels[0].status, MathLevelStatus.completed);
    expect(levels[0].stars, 3);
    expect(levels[3].status, MathLevelStatus.available);
    expect(levels[4].status, MathLevelStatus.locked);
  });
}
