import '../../domain/addition_exercise.dart';

abstract final class AdditionExerciseGenerator {
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
}
