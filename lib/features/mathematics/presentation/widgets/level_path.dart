import 'package:flutter/material.dart';

class LevelPathPainter extends CustomPainter {
  const LevelPathPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()..moveTo(size.width * .3, 20);
    for (var i = 1; i <= 12; i++) {
      final y = i * 135.0;
      final x = i.isEven ? size.width * .7 : size.width * .3;
      path.quadraticBezierTo(size.width * .5, y - 65, x, y);
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFFFFDA70)
        ..strokeWidth = 30
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFFFFF0B7)
        ..strokeWidth = 4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
