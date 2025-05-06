import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sholat/flower/model.dart';

class FlowerPainter extends CustomPainter {
  final List<PainterText> texts;
  final List<Path> petalPaths = [];

  FlowerPainter({super.repaint, required this.texts});

  @override
  void paint(Canvas canvas, Size size) {
    final int numberOfPetals = texts.length;
    final double radius = size.width / 1.7;
    final Paint paint = Paint()..color = Colors.pinkAccent;

    final Offset center = Offset(size.width / 2, size.height / 2);
    petalPaths.clear();

    for (final item in texts.asMap().entries) {
      final i = item.key;
      final text = item.value;
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

      // final builder = TextPainter(
      //   text: TextSpan(
      //     text: String.fromCharCode(icon.codePoint),
      //     style: TextStyle(
      //       fontSize: 12,
      //       fontFamily: icon.fontFamily,
      //       color: Colors.black,
      //     ),
      //   ),
      //   textDirection: TextDirection.ltr,
      // );
      // builder.layout();
      // builder.paint(canvas, textOffset);
    }

    // Optional: draw the center of the flower
    canvas.drawCircle(center, size.width / 3, Paint()..color = Colors.yellow);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
