class AdditionExercise {
  const AdditionExercise({
    required this.left,
    required this.right,
    required this.answers,
  });

  final int left;
  final int right;
  final List<int> answers;

  int get correctAnswer => left + right;

  bool checkAnswer(int answer) => answer == correctAnswer;
}
