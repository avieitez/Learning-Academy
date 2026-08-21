import 'package:flutter/material.dart';

class LevelPathPainter extends CustomPainter {
  const LevelPathPainter();

  @override
  void paint(Canvas canvas, Size size) {
    _paintLandscape(canvas, size);
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

  void _paintLandscape(Canvas canvas, Size size) {
    final farHills = Path()
      ..moveTo(0, 130)
      ..quadraticBezierTo(size.width * .25, 20, size.width * .5, 120)
      ..quadraticBezierTo(size.width * .78, 210, size.width, 80)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(farHills, Paint()..color = const Color(0x5571D65B));

    final river = Path()..moveTo(size.width * .9, 0);
    for (var y = 0.0; y <= size.height; y += 180) {
      final x = y ~/ 180 % 2 == 0 ? size.width * .88 : size.width * .12;
      river.quadraticBezierTo(size.width * .5, y + 90, x, y + 180);
    }
    canvas.drawPath(
      river,
      Paint()
        ..color = const Color(0x8840C8F4)
        ..strokeWidth = 42
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    final dots = Paint()..color = const Color(0x66FFF176);
    for (var i = 0; i < 30; i++) {
      final x = ((i * 83) % 100) / 100 * size.width;
      final y = ((i * 137) % 1000) / 1000 * size.height;
      canvas.drawCircle(Offset(x, y), 3 + (i % 3).toDouble(), dots);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
