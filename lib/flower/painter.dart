import 'dart:math';

import 'package:flutter/material.dart';

class FlowerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final int numberOfPetals = 6;
    final double radius = size.width / 1.7;
    final Paint paint = Paint()..color = Colors.pinkAccent;

    final Offset center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < numberOfPetals; i++) {
      final double angle = (2 * pi / numberOfPetals) * i;
      final double x = center.dx + radius * cos(angle);
      final double y = center.dy + radius * sin(angle);

      final duaPuluh = size.width / 3;

      final Path petal =
          Path()
            ..moveTo(center.dx, center.dy)
            ..quadraticBezierTo(
              (center.dx + x) / 2 + duaPuluh * cos(angle - pi / 2),
              (center.dy + y) / 2 + duaPuluh * sin(angle - pi / 2),
              x,
              y,
            )
            ..quadraticBezierTo(
              (center.dx + x) / 2 + duaPuluh * cos(angle + pi / 2),
              (center.dy + y) / 2 + duaPuluh * sin(angle + pi / 2),
              center.dx,
              center.dy,
            )
            ..close();

      canvas.drawPath(petal, paint);

      // Draw text on each petal
      final textPainter = TextPainter(
        text: TextSpan(
          text: "$i",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
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

      textPainter.paint(canvas, textOffset);
    }

    // Optional: draw the center of the flower
    canvas.drawCircle(center, size.width / 3, Paint()..color = Colors.yellow);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
