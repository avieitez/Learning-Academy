import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
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
  final AudioPlayer _animalPlayer = AudioPlayer();
  int _animalPlaybackId = 0;

  @override
  void dispose() {
    unawaited(_animalPlayer.dispose());
    super.dispose();
  }

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
                          _MapAnimals(
                            dogLabel: l10n.dog,
                            sheepLabel: l10n.sheep,
                            roosterLabel: l10n.rooster,
                            horseLabel: l10n.horse,
                            tapHint: l10n.tapToHearAnimal,
                            onAnimalPressed: _playAnimalSound,
                          ),
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
                          _SlidingMapMascot(
                            key: const ValueKey('map-mascot'),
                            selectedLevel: _selectedLevel!,
                            mapWidth: constraints.maxWidth,
                            emoji: mascot.emoji,
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

  Future<void> _playAnimalSound(String asset) async {
    final playbackId = ++_animalPlaybackId;
    try {
      await _animalPlayer.stop();
      await _animalPlayer.play(AssetSource(asset), volume: .75);
      await Future<void>.delayed(const Duration(milliseconds: 1900));
      if (playbackId == _animalPlaybackId) await _animalPlayer.stop();
    } catch (_) {
      // A decorative interaction must never interrupt map navigation.
    }
  }

  String _operationTitle(AppLocalizations l) => switch (widget.operation) {
    MathOperation.addition => l.addition,
    MathOperation.subtraction => l.subtraction,
    MathOperation.multiplication => l.multiplication,
    MathOperation.division => l.division,
  };

  void _playSelectedLevel(BuildContext context, AppLocalizations l10n) {
    if (widget.operation == MathOperation.addition) {
      Navigator.pushNamed(
        context,
        AppRoutes.mathematicsExercise,
        arguments: _selectedLevel,
      );
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

class _MapAnimals extends StatelessWidget {
  const _MapAnimals({
    required this.dogLabel,
    required this.sheepLabel,
    required this.roosterLabel,
    required this.horseLabel,
    required this.tapHint,
    required this.onAnimalPressed,
  });

  final String dogLabel;
  final String sheepLabel;
  final String roosterLabel;
  final String horseLabel;
  final String tapHint;
  final ValueChanged<String> onAnimalPressed;

  @override
  Widget build(BuildContext context) => Positioned.fill(
    child: LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          Positioned(
            top: 250,
            left: constraints.maxWidth * .03,
            child: _SoundAnimal(
              key: const ValueKey('map-animal-dog'),
              asset: 'assets/images/animals/dog.png',
              label: dogLabel,
              tapHint: tapHint,
              onPressed: () => onAnimalPressed('sounds/animals/dog.mp3'),
            ),
          ),
          Positioned(
            top: 835,
            right: constraints.maxWidth * .03,
            child: _SoundAnimal(
              key: const ValueKey('map-animal-sheep'),
              asset: 'assets/images/animals/sheep.png',
              label: sheepLabel,
              tapHint: tapHint,
              onPressed: () => onAnimalPressed('sounds/animals/sheep.mp3'),
            ),
          ),
          Positioned(
            top: 1110,
            left: constraints.maxWidth * .03,
            child: _SoundAnimal(
              key: const ValueKey('map-animal-rooster'),
              asset: 'assets/images/animals/rooster.png',
              label: roosterLabel,
              tapHint: tapHint,
              onPressed: () => onAnimalPressed('sounds/animals/rooster.mp3'),
            ),
          ),
          Positioned(
            top: 1430,
            right: constraints.maxWidth * .03,
            child: _SoundAnimal(
              key: const ValueKey('map-animal-horse'),
              asset: 'assets/images/animals/horse.png',
              label: horseLabel,
              tapHint: tapHint,
              onPressed: () => onAnimalPressed('sounds/animals/horse.mp3'),
            ),
          ),
        ],
      ),
    ),
  );
}

class _SoundAnimal extends StatefulWidget {
  const _SoundAnimal({
    required this.asset,
    required this.label,
    required this.tapHint,
    required this.onPressed,
    super.key,
  });

  final String asset;
  final String label;
  final String tapHint;
  final VoidCallback onPressed;

  @override
  State<_SoundAnimal> createState() => _SoundAnimalState();
}

class _SoundAnimalState extends State<_SoundAnimal> {
  bool _reacting = false;

  Future<void> _react() async {
    if (_reacting) return;
    widget.onPressed();
    setState(() => _reacting = true);
    await Future<void>.delayed(const Duration(milliseconds: 650));
    if (mounted) setState(() => _reacting = false);
  }

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: widget.label,
    hint: widget.tapHint,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _react,
      child: SizedBox(
        width: 68,
        height: 68,
        child: Center(
          child: AnimatedScale(
            scale: _reacting ? 1.3 : 1,
            duration: const Duration(milliseconds: 240),
            curve: Curves.elasticOut,
            child: AnimatedRotation(
              turns: _reacting ? .04 : 0,
              duration: const Duration(milliseconds: 220),
              child: Image.asset(
                widget.asset,
                width: 64,
                height: 64,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _SlidingMapMascot extends StatelessWidget {
  const _SlidingMapMascot({
    required this.selectedLevel,
    required this.mapWidth,
    required this.emoji,
    super.key,
  });

  final int selectedLevel;
  final double mapWidth;
  final String emoji;

  double _leftForIndex(int index) =>
      index.isEven ? mapWidth * .17 + 80 : mapWidth * .57 - 62;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween<double>(end: (selectedLevel - 1).toDouble()),
    duration: const Duration(milliseconds: 1200),
    curve: Curves.easeInOutSine,
    builder: (context, position, child) {
      final lowerIndex = position.floor();
      final upperIndex = position.ceil();
      final segmentProgress = position - lowerIndex;
      final left =
          _leftForIndex(lowerIndex) +
          (_leftForIndex(upperIndex) - _leftForIndex(lowerIndex)) *
              segmentProgress;
      return Positioned(top: 48 + position * 135, left: left, child: child!);
    },
    child: _MapMascot(emoji: emoji),
  );
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
