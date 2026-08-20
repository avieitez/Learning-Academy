enum MathLevelStatus { completed, available, locked }

class MathLevel {
  const MathLevel({
    required this.number,
    required this.status,
    required this.stars,
  });
  final int number;
  final MathLevelStatus status;
  final int stars;
}
