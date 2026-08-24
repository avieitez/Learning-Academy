import 'package:flutter_test/flutter_test.dart';
import 'package:learning_academy/features/mathematics/data/mathematics_catalog.dart';
import 'package:learning_academy/features/mathematics/domain/math_level.dart';
import 'package:learning_academy/features/mathematics/data/generators/addition_exercise_generator.dart';

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

  test('addition level one contains ten valid visual exercises', () {
    final exercises = AdditionExerciseGenerator.levelOne();

    expect(exercises, hasLength(10));
    for (final exercise in exercises) {
      expect(exercise.answers, hasLength(3));
      expect(exercise.answers.toSet(), hasLength(3));
      expect(exercise.answers, contains(exercise.correctAnswer));
      expect(exercise.correctAnswer, lessThanOrEqualTo(8));
    }
  });

  test('addition levels two and three progress gradually', () {
    final levelTwo = AdditionExerciseGenerator.levelTwo();
    final levelThree = AdditionExerciseGenerator.levelThree();

    expect(levelTwo, hasLength(10));
    expect(levelThree, hasLength(10));
    expect(
      levelTwo.map((exercise) => exercise.correctAnswer),
      everyElement(inInclusiveRange(7, 12)),
    );
    expect(
      levelThree.map((exercise) => exercise.correctAnswer),
      everyElement(inInclusiveRange(12, 20)),
    );

    for (final exercise in [...levelTwo, ...levelThree]) {
      expect(exercise.answers, hasLength(3));
      expect(exercise.answers.toSet(), hasLength(3));
      expect(exercise.answers, contains(exercise.correctAnswer));
    }
  });

  test('all twelve addition levels contain ten valid exercises', () {
    for (var level = 1; level <= MathematicsCatalog.levelCount; level++) {
      final exercises = AdditionExerciseGenerator.forLevel(level);
      expect(exercises, hasLength(10), reason: 'level $level');
      for (final exercise in exercises) {
        expect(exercise.answers, hasLength(3), reason: 'level $level');
        expect(exercise.answers.toSet(), hasLength(3), reason: 'level $level');
        expect(
          exercise.answers,
          contains(exercise.correctAnswer),
          reason: 'level $level: ${exercise.left} + ${exercise.right}',
        );
        expect(
          exercise.correctAnswer,
          inInclusiveRange(1, 100),
          reason: 'level $level',
        );
      }
    }
  });

  test('advanced levels introduce place value and regrouping', () {
    expect(
      AdditionExerciseGenerator.forLevel(
        9,
      ).map((exercise) => exercise.correctAnswer),
      everyElement(predicate<int>((answer) => answer % 10 == 0)),
    );
    expect(AdditionExerciseGenerator.forLevel(12).last.correctAnswer, 100);
  });
}
