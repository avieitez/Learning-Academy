abstract final class AdditionVisualCatalog {
  static const fruits = <String>[
    '🍎',
    '🍊',
    '🍓',
    '🍌',
    '🍉',
    '🍇',
    '🍒',
    '🍍',
    '🥝',
    '🍑',
  ];

  static String fruitFor({required int level, required int exerciseIndex}) {
    final levelOffset = (level - 1) * 3;
    return fruits[(levelOffset + exerciseIndex) % fruits.length];
  }
}
