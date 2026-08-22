import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../app/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../../settings/domain/app_preferences.dart';
import '../data/mathematics_catalog.dart';
import '../domain/math_level.dart';
import '../domain/math_operation.dart';
import 'widgets/level_node.dart';
import 'widgets/level_path.dart';

class LevelMapScreen extends StatefulWidget {
  const LevelMapScreen({required this.operation, super.key});
  final MathOperation operation;

  @override
  State<LevelMapScreen> createState() => _LevelMapScreenState();
}

class _LevelMapScreenState extends State<LevelMapScreen> {
  int? _selectedLevel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final unlockedLevel = AppPreferencesScope.of(
      context,
    ).value.unlockedLevel('mathematics', widget.operation.name);
    final mascot = AppPreferencesScope.of(context).value.mascot;
    final levels = MathematicsCatalog.levels(currentLevel: unlockedLevel);
    _selectedLevel ??= unlockedLevel;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF65D1F4), Color(0xFF8FE36A), Color(0xFF39B85A)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _MapHeader(title: l10n.levelMap, subtitle: _operationTitle(l10n)),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: SizedBox(
                    height: MathematicsCatalog.levelCount * 135 + 80,
                    child: LayoutBuilder(
                      builder: (context, constraints) => Stack(
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: const LevelPathPainter(),
                            ),
                          ),
                          const _MapDecorations(),
                          for (var index = 0; index < levels.length; index++)
                            Positioned(
                              top: 28 + index * 135,
                              left: index.isEven
                                  ? constraints.maxWidth * .17
                                  : constraints.maxWidth * .57,
                              child: LevelNode(
                                key: ValueKey('level-${index + 1}'),
                                level: levels[index],
                                selected: _selectedLevel == index + 1,
                                onPressed:
                                    levels[index].status ==
                                        MathLevelStatus.locked
                                    ? null
                                    : () => setState(
                                        () => _selectedLevel = index + 1,
                                      ),
                              ),
                            ),
                          for (var block = 1; block <= 3; block++)
                            Positioned(
                              top: block * 540 - 65,
                              left: constraints.maxWidth * .38,
                              child: const _TreasureChest(),
                            ),
                          AnimatedPositioned(
                            key: const ValueKey('map-mascot'),
                            duration: const Duration(milliseconds: 650),
                            curve: Curves.easeInOutBack,
                            top: 48 + (_selectedLevel! - 1) * 135,
                            left: (_selectedLevel! - 1).isEven
                                ? constraints.maxWidth * .17 + 80
                                : constraints.maxWidth * .57 - 62,
                            child: _MapMascot(emoji: mascot.emoji),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 16,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: FilledButton.icon(
                    key: const ValueKey('play-level'),
                    onPressed: () => _playSelectedLevel(context, l10n),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    icon: const Icon(Icons.play_arrow_rounded, size: 34),
                    label: Text(
                      '${l10n.play} · ${l10n.level} ${_selectedLevel!}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _operationTitle(AppLocalizations l) => switch (widget.operation) {
    MathOperation.addition => l.addition,
    MathOperation.subtraction => l.subtraction,
    MathOperation.multiplication => l.multiplication,
    MathOperation.division => l.division,
  };

  void _playSelectedLevel(BuildContext context, AppLocalizations l10n) {
    if (widget.operation == MathOperation.addition && _selectedLevel == 1) {
      Navigator.pushNamed(context, AppRoutes.mathematicsExercise);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.exercisesComingNext),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _MapMascot extends StatelessWidget {
  const _MapMascot({required this.emoji});
  final String emoji;

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Selected mascot',
    child: Container(
      width: 58,
      height: 58,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFFFD84A), width: 4),
        boxShadow: const [
          BoxShadow(
            color: Color(0x44000000),
            blurRadius: 8,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Text(emoji, style: const TextStyle(fontSize: 34)),
    ),
  );
}

class _MapDecorations extends StatelessWidget {
  const _MapDecorations();

  static const items = <({double top, double left, String emoji, double size})>[
    (top: 80, left: .78, emoji: '☁️', size: 36),
    (top: 185, left: .05, emoji: '🌳', size: 44),
    (top: 330, left: .78, emoji: '🌲', size: 46),
    (top: 470, left: .08, emoji: '🌼', size: 28),
    (top: 620, left: .76, emoji: '🏡', size: 44),
    (top: 760, left: .05, emoji: '🦋', size: 28),
    (top: 900, left: .78, emoji: '🌳', size: 46),
    (top: 1060, left: .06, emoji: '🌸', size: 28),
    (top: 1210, left: .77, emoji: '🌲', size: 46),
    (top: 1390, left: .07, emoji: '🏕️', size: 42),
  ];

  @override
  Widget build(BuildContext context) => Positioned.fill(
    child: LayoutBuilder(
      builder: (context, constraints) => ExcludeSemantics(
        child: Stack(
          children: [
            for (final item in items)
              Positioned(
                top: item.top,
                left: constraints.maxWidth * item.left,
                child: Text(item.emoji, style: TextStyle(fontSize: item.size)),
              ),
          ],
        ),
      ),
    ),
  );
}

class _MapHeader extends StatelessWidget {
  const _MapHeader({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(14, 8, 14, 8),
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFFFB01E), Color(0xFFF36C16)],
      ),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: Colors.white, width: 4),
      boxShadow: const [
        BoxShadow(color: Color(0x44000000), offset: Offset(0, 5)),
      ],
    ),
    child: Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 48),
      ],
    ),
  );
}

class _TreasureChest extends StatelessWidget {
  const _TreasureChest();
  @override
  Widget build(BuildContext context) => Container(
    width: 78,
    height: 64,
    decoration: BoxDecoration(
      color: const Color(0xFFB7501D),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFFFC52D), width: 7),
      boxShadow: const [
        BoxShadow(color: Color(0x44000000), offset: Offset(0, 6)),
      ],
    ),
    child: const Icon(Icons.lock_rounded, color: Color(0xFFFFD23F), size: 30),
  );
}
