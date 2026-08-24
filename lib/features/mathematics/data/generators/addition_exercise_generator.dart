import '../../domain/addition_exercise.dart';

abstract final class AdditionExerciseGenerator {
  static List<AdditionExercise> forLevel(int level) => switch (level) {
    1 => levelOne(),
    2 => levelTwo(),
    3 => levelThree(),
    4 => levelFour(),
    5 => levelFive(),
    6 => levelSix(),
    7 => levelSeven(),
    8 => levelEight(),
    9 => levelNine(),
    10 => levelTen(),
    11 => levelEleven(),
    12 => levelTwelve(),
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

  // Number bonds and mixed additions up to 20.
  static List<AdditionExercise> levelFour() => const [
    AdditionExercise(left: 11, right: 2, answers: [12, 13, 14]),
    AdditionExercise(left: 12, right: 3, answers: [15, 14, 16]),
    AdditionExercise(left: 13, right: 4, answers: [16, 18, 17]),
    AdditionExercise(left: 14, right: 5, answers: [19, 18, 20]),
    AdditionExercise(left: 15, right: 3, answers: [17, 18, 19]),
    AdditionExercise(left: 11, right: 7, answers: [18, 17, 19]),
    AdditionExercise(left: 12, right: 6, answers: [19, 18, 17]),
    AdditionExercise(left: 13, right: 6, answers: [18, 20, 19]),
    AdditionExercise(left: 14, right: 6, answers: [20, 19, 21]),
    AdditionExercise(left: 15, right: 5, answers: [19, 20, 21]),
  ];

  // Doubles and near doubles build mental-calculation confidence.
  static List<AdditionExercise> levelFive() => const [
    AdditionExercise(left: 6, right: 6, answers: [11, 12, 13]),
    AdditionExercise(left: 6, right: 7, answers: [13, 12, 14]),
    AdditionExercise(left: 7, right: 7, answers: [15, 13, 14]),
    AdditionExercise(left: 7, right: 8, answers: [14, 15, 16]),
    AdditionExercise(left: 8, right: 8, answers: [16, 15, 17]),
    AdditionExercise(left: 8, right: 9, answers: [18, 17, 16]),
    AdditionExercise(left: 9, right: 9, answers: [17, 19, 18]),
    AdditionExercise(left: 9, right: 10, answers: [19, 18, 20]),
    AdditionExercise(left: 10, right: 10, answers: [21, 19, 20]),
    AdditionExercise(left: 10, right: 9, answers: [18, 19, 20]),
  ];

  // Adding complete tens introduces place value.
  static List<AdditionExercise> levelSix() => const [
    AdditionExercise(left: 10, right: 4, answers: [13, 14, 15]),
    AdditionExercise(left: 10, right: 8, answers: [18, 17, 19]),
    AdditionExercise(left: 20, right: 3, answers: [22, 24, 23]),
    AdditionExercise(left: 20, right: 7, answers: [27, 26, 28]),
    AdditionExercise(left: 30, right: 5, answers: [34, 35, 36]),
    AdditionExercise(left: 12, right: 10, answers: [21, 22, 23]),
    AdditionExercise(left: 17, right: 10, answers: [27, 26, 28]),
    AdditionExercise(left: 23, right: 10, answers: [32, 34, 33]),
    AdditionExercise(left: 28, right: 10, answers: [38, 37, 39]),
    AdditionExercise(left: 35, right: 10, answers: [44, 45, 46]),
  ];

  // Crossing a ten with a one-digit addend.
  static List<AdditionExercise> levelSeven() => const [
    AdditionExercise(left: 8, right: 5, answers: [12, 13, 14]),
    AdditionExercise(left: 9, right: 6, answers: [15, 14, 16]),
    AdditionExercise(left: 17, right: 5, answers: [21, 22, 23]),
    AdditionExercise(left: 18, right: 7, answers: [25, 24, 26]),
    AdditionExercise(left: 19, right: 8, answers: [26, 28, 27]),
    AdditionExercise(left: 26, right: 6, answers: [31, 32, 33]),
    AdditionExercise(left: 27, right: 5, answers: [32, 31, 33]),
    AdditionExercise(left: 28, right: 7, answers: [34, 35, 36]),
    AdditionExercise(left: 29, right: 4, answers: [32, 34, 33]),
    AdditionExercise(left: 36, right: 5, answers: [40, 41, 42]),
  ];

  // Two-digit plus one-digit additions up to 60.
  static List<AdditionExercise> levelEight() => const [
    AdditionExercise(left: 21, right: 6, answers: [26, 27, 28]),
    AdditionExercise(left: 32, right: 5, answers: [37, 36, 38]),
    AdditionExercise(left: 43, right: 4, answers: [46, 48, 47]),
    AdditionExercise(left: 51, right: 8, answers: [59, 58, 60]),
    AdditionExercise(left: 24, right: 5, answers: [28, 29, 30]),
    AdditionExercise(left: 33, right: 6, answers: [39, 38, 40]),
    AdditionExercise(left: 42, right: 7, answers: [48, 50, 49]),
    AdditionExercise(left: 50, right: 9, answers: [59, 58, 60]),
    AdditionExercise(left: 31, right: 8, answers: [38, 39, 40]),
    AdditionExercise(left: 44, right: 5, answers: [49, 48, 50]),
  ];

  // Complete tens make the base-ten system explicit.
  static List<AdditionExercise> levelNine() => const [
    AdditionExercise(left: 10, right: 20, answers: [20, 30, 40]),
    AdditionExercise(left: 20, right: 20, answers: [40, 30, 50]),
    AdditionExercise(left: 20, right: 30, answers: [40, 60, 50]),
    AdditionExercise(left: 30, right: 30, answers: [60, 50, 70]),
    AdditionExercise(left: 40, right: 20, answers: [50, 60, 70]),
    AdditionExercise(left: 40, right: 30, answers: [70, 60, 80]),
    AdditionExercise(left: 50, right: 20, answers: [60, 80, 70]),
    AdditionExercise(left: 50, right: 30, answers: [80, 70, 90]),
    AdditionExercise(left: 60, right: 20, answers: [70, 80, 90]),
    AdditionExercise(left: 50, right: 50, answers: [90, 100, 80]),
  ];

  // Two-digit additions without regrouping.
  static List<AdditionExercise> levelTen() => const [
    AdditionExercise(left: 21, right: 13, answers: [33, 34, 35]),
    AdditionExercise(left: 32, right: 16, answers: [48, 47, 49]),
    AdditionExercise(left: 43, right: 25, answers: [67, 69, 68]),
    AdditionExercise(left: 51, right: 28, answers: [79, 78, 80]),
    AdditionExercise(left: 24, right: 35, answers: [58, 59, 60]),
    AdditionExercise(left: 33, right: 44, answers: [77, 76, 78]),
    AdditionExercise(left: 42, right: 26, answers: [67, 69, 68]),
    AdditionExercise(left: 61, right: 17, answers: [78, 77, 79]),
    AdditionExercise(left: 52, right: 34, answers: [85, 86, 87]),
    AdditionExercise(left: 70, right: 29, answers: [98, 99, 100]),
  ];

  // Two-digit additions with regrouping through the next ten.
  static List<AdditionExercise> levelEleven() => const [
    AdditionExercise(left: 27, right: 15, answers: [41, 42, 43]),
    AdditionExercise(left: 38, right: 24, answers: [62, 61, 63]),
    AdditionExercise(left: 46, right: 17, answers: [62, 64, 63]),
    AdditionExercise(left: 29, right: 35, answers: [64, 63, 65]),
    AdditionExercise(left: 57, right: 26, answers: [82, 83, 84]),
    AdditionExercise(left: 48, right: 34, answers: [82, 81, 83]),
    AdditionExercise(left: 36, right: 47, answers: [82, 84, 83]),
    AdditionExercise(left: 58, right: 27, answers: [85, 84, 86]),
    AdditionExercise(left: 69, right: 23, answers: [91, 92, 93]),
    AdditionExercise(left: 47, right: 49, answers: [95, 97, 96]),
  ];

  // Final mixed challenge: flexible addition strategies up to 100.
  static List<AdditionExercise> levelTwelve() => const [
    AdditionExercise(left: 18, right: 19, answers: [36, 37, 38]),
    AdditionExercise(left: 25, right: 25, answers: [50, 49, 51]),
    AdditionExercise(left: 37, right: 28, answers: [64, 66, 65]),
    AdditionExercise(left: 45, right: 35, answers: [80, 79, 81]),
    AdditionExercise(left: 54, right: 29, answers: [82, 83, 84]),
    AdditionExercise(left: 63, right: 17, answers: [80, 79, 81]),
    AdditionExercise(left: 72, right: 18, answers: [89, 91, 90]),
    AdditionExercise(left: 46, right: 46, answers: [92, 91, 93]),
    AdditionExercise(left: 58, right: 39, answers: [96, 97, 98]),
    AdditionExercise(left: 64, right: 36, answers: [99, 100, 98]),
  ];
}
