import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sholat/flower/model.dart';

class FlowerPainter extends CustomPainter {
  final List<PainterText> texts;
  final List<Path> petalPaths = [];
  final double qiblaAngle;

  FlowerPainter({super.repaint, required this.texts, required this.qiblaAngle});

  void _drawPetal(Canvas canvas, Size size, Offset center) {
    petalPaths.clear();

    final int numberOfPetals = texts.length;
    final double radius = size.width / 1.7;
    final Paint paint = Paint()..color = Colors.pinkAccent;
    for (final item in texts.asMap().entries) {
      final i = item.key;
      final text = item.value;
      final double angle = (2 * pi / numberOfPetals) * i;
      final double x = center.dx + radius * cos(angle);
      final double y = center.dy + radius * sin(angle);

      final bezierWidth = size.width / 3;

      final Path petal =
          Path()
            ..moveTo(center.dx, center.dy)
            ..quadraticBezierTo(
              (center.dx + x) / 2 + bezierWidth * cos(angle - pi / 2),
              (center.dy + y) / 2 + bezierWidth * sin(angle - pi / 2),
              x,
              y,
            )
            ..quadraticBezierTo(
              (center.dx + x) / 2 + bezierWidth * cos(angle + pi / 2),
              (center.dy + y) / 2 + bezierWidth * sin(angle + pi / 2),
              center.dx,
              center.dy,
            )
            ..close();

      canvas.drawPath(petal, paint);
      petalPaths.add(petal);

      // Draw text on each petal
      final icon = text.icon;

      final textPainter = TextPainter(
        text: TextSpan(
          text: text.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          children: [
            TextSpan(text: '\n${text.subtitle}\n'),
            TextSpan(
              text: String.fromCharCode(icon.codePoint),
              style: TextStyle(fontSize: 12, fontFamily: icon.fontFamily),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();

      // Position text near tip of petal, slightly offset back toward center
      final double textRadius = radius - 50;
      final Offset textOffset = Offset(
        center.dx + textRadius * cos(angle) - textPainter.width / 2,
        center.dy + textRadius * sin(angle) - textPainter.height / 2,
      );

      textPainter.layout();
      textPainter.paint(canvas, textOffset);
    }
  }

  void _drawCircle(Canvas canvas, Offset center, Size size) {
    // canvas.drawCircle(center, size.width / 3, Paint()..color = Colors.yellow);

    final radius = size.width / 3;

    final Paint circlePaint = Paint()..color = Colors.yellow;

    canvas.drawCircle(center, radius, circlePaint);

    final double radians = qiblaAngle * (pi / 180);
    final double needleLength = radius - 20;

    final needleEnd = Offset(
      center.dx + needleLength * sin(radians),
      center.dy - needleLength * cos(radians),
    );

    final Paint needlePaint =
        Paint()
          ..color = Colors.red
          ..strokeWidth = 4;

    canvas.drawLine(center, needleEnd, needlePaint);
    canvas.drawCircle(center, 6, Paint()..color = Colors.black);

  }

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);

    _drawPetal(canvas, size, center);

    _drawCircle(canvas, center, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
