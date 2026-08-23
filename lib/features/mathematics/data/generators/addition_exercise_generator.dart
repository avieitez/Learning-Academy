import '../../domain/addition_exercise.dart';

abstract final class AdditionExerciseGenerator {
  static List<AdditionExercise> forLevel(int level) => switch (level) {
    1 => levelOne(),
    2 => levelTwo(),
    3 => levelThree(),
    _ => throw ArgumentError.value(
      level,
      'level',
      'Unsupported addition level',
    ),
  };

  static List<AdditionExercise> levelOne() => const [
    AdditionExercise(left: 1, right: 1, answers: [2, 3, 1]),
    AdditionExercise(left: 2, right: 1, answers: [2, 3, 4]),
    AdditionExercise(left: 1, right: 3, answers: [5, 3, 4]),
    AdditionExercise(left: 2, right: 2, answers: [4, 5, 3]),
    AdditionExercise(left: 3, right: 2, answers: [4, 5, 6]),
    AdditionExercise(left: 1, right: 4, answers: [6, 4, 5]),
    AdditionExercise(left: 3, right: 3, answers: [6, 5, 7]),
    AdditionExercise(left: 4, right: 2, answers: [5, 7, 6]),
    AdditionExercise(left: 2, right: 5, answers: [7, 6, 8]),
    AdditionExercise(left: 4, right: 4, answers: [9, 8, 7]),
  ];

  static List<AdditionExercise> levelTwo() => const [
    AdditionExercise(left: 5, right: 2, answers: [6, 7, 8]),
    AdditionExercise(left: 4, right: 3, answers: [7, 8, 6]),
    AdditionExercise(left: 6, right: 2, answers: [9, 7, 8]),
    AdditionExercise(left: 5, right: 4, answers: [8, 10, 9]),
    AdditionExercise(left: 7, right: 3, answers: [10, 9, 11]),
    AdditionExercise(left: 6, right: 4, answers: [11, 10, 9]),
    AdditionExercise(left: 5, right: 6, answers: [10, 12, 11]),
    AdditionExercise(left: 7, right: 4, answers: [11, 12, 10]),
    AdditionExercise(left: 6, right: 6, answers: [13, 11, 12]),
    AdditionExercise(left: 7, right: 5, answers: [12, 11, 13]),
  ];

  static List<AdditionExercise> levelThree() => const [
    AdditionExercise(left: 8, right: 4, answers: [11, 12, 13]),
    AdditionExercise(left: 7, right: 6, answers: [13, 12, 14]),
    AdditionExercise(left: 9, right: 5, answers: [15, 13, 14]),
    AdditionExercise(left: 8, right: 7, answers: [14, 16, 15]),
    AdditionExercise(left: 9, right: 7, answers: [16, 15, 17]),
    AdditionExercise(left: 8, right: 8, answers: [17, 16, 15]),
    AdditionExercise(left: 10, right: 7, answers: [16, 18, 17]),
    AdditionExercise(left: 9, right: 9, answers: [18, 17, 19]),
    AdditionExercise(left: 10, right: 8, answers: [19, 18, 17]),
    AdditionExercise(left: 10, right: 10, answers: [19, 21, 20]),
  ];
}
