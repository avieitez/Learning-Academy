class Mascot {
  const Mascot({required this.id, required this.emoji});

  final String id;
  final String emoji;

  static const owl = Mascot(id: 'owl', emoji: '🦉');
  static const fox = Mascot(id: 'fox', emoji: '🦊');
  static const panda = Mascot(id: 'panda', emoji: '🐼');
  static const lion = Mascot(id: 'lion', emoji: '🦁');
  static const bunny = Mascot(id: 'bunny', emoji: '🐰');
  static const unicorn = Mascot(id: 'unicorn', emoji: '🦄');

  static const values = [owl, fox, panda, lion, bunny, unicorn];

  static Mascot fromId(String? id) =>
      values.firstWhere((mascot) => mascot.id == id, orElse: () => owl);
}
