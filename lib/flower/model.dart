import 'package:flutter/material.dart';

class PrayerItem {
  final String key;
  final TimeOfDay time;
  final VoidCallback onTap;
  final IconData icon;
  bool isActive;

  PrayerItem({
    required this.key,
    required this.time,
    required this.onTap,
    required bool isMuted,
    required this.isActive,
  }) : icon = isMuted ? Icons.alarm_off : Icons.alarm;
}
