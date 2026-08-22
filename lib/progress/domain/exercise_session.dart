class ExerciseSession {
  const ExerciseSession({
    required this.area,
    required this.activity,
    required this.level,
    required this.exerciseIndex,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.startedAt,
  });

  final String area;
  final String activity;
  final int level;
  final int exerciseIndex;
  final int correctAnswers;
  final int incorrectAnswers;
  final DateTime startedAt;

  String get key => '$area/$activity/$level';

  Map<String, Object> toJson() => {
    'area': area,
    'activity': activity,
    'level': level,
    'exerciseIndex': exerciseIndex,
    'correctAnswers': correctAnswers,
    'incorrectAnswers': incorrectAnswers,
    'startedAt': startedAt.toIso8601String(),
  };

  factory ExerciseSession.fromJson(Map<String, dynamic> json) =>
      ExerciseSession(
        area: json['area'] as String,
        activity: json['activity'] as String,
        level: json['level'] as int,
        exerciseIndex: json['exerciseIndex'] as int,
        correctAnswers: json['correctAnswers'] as int,
        incorrectAnswers: json['incorrectAnswers'] as int,
        startedAt: DateTime.parse(json['startedAt'] as String),
      );
}
