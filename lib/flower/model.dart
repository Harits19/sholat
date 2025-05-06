import 'package:flutter/material.dart';

class PainterText {
  final String title, subtitle;
  final VoidCallback onTap;
  final IconData icon;

  PainterText({
    required this.title,
    required this.subtitle,
    required this.onTap,
    required bool isMuted,
  }) : icon = isMuted ? Icons.alarm_off : Icons.alarm;
}
