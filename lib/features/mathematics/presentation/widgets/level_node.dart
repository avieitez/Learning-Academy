import 'package:flutter/material.dart';

import '../../domain/math_level.dart';

class LevelNode extends StatelessWidget {
  const LevelNode({
    required this.level,
    required this.selected,
    required this.onPressed,
    super.key,
  });
  final MathLevel level;
  final bool selected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final locked = level.status == MathLevelStatus.locked;
    final color = locked
        ? const Color(0xFF6B7080)
        : level.status == MathLevelStatus.available
        ? const Color(0xFF2E9EED)
        : const Color(0xFFF15A43);
    return Semantics(
      button: !locked,
      enabled: !locked,
      label: 'Level ${level.number}',
      child: AnimatedScale(
        scale: selected ? 1.08 : 1,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutBack,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: Ink(
              width: 104,
              height: 104,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 6),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: .42),
                    blurRadius: selected ? 22 : 8,
                    spreadRadius: selected ? 5 : 0,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: locked
                  ? const Icon(
                      Icons.lock_rounded,
                      color: Colors.white,
                      size: 43,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (level.stars > 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                              (_) => const Icon(
                                Icons.star_rounded,
                                color: Color(0xFFFFD83D),
                                size: 18,
                              ),
                            ),
                          ),
                        Text(
                          '${level.number}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            height: 1,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
