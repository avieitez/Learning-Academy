class ProgressKey {
  const ProgressKey({required this.area, required this.activity});

  final String area;
  final String activity;

  String get storageKey => '$area/$activity';
}
