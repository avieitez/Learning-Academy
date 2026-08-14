import 'package:flutter/material.dart';

class LearningAreaCard extends StatelessWidget {
  const LearningAreaCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: onPressed != null,
      enabled: onPressed != null,
      label: '$title. $subtitle',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(28),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color.lerp(color, Colors.white, .18)!, color],
              ),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white, width: 5),
              boxShadow: [
                BoxShadow(
                  color: Color.lerp(color, Colors.black, .28)!,
                  offset: const Offset(0, 7),
                ),
                const BoxShadow(
                  color: Color(0x260C5A80),
                  blurRadius: 18,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 12,
                  top: 12,
                  child: Icon(
                    Icons.star_rounded,
                    color: Colors.white.withValues(alpha: .35),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 21,
                          height: 1,
                          shadows: const [
                            Shadow(
                              color: Color(0x55000000),
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Center(
                          child: Container(
                            width: 76,
                            height: 70,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF8DD),
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x44000000),
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Icon(icon, size: 46, color: color),
                          ),
                        ),
                      ),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          height: 1.1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
