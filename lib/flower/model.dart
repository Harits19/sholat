import 'package:flutter/material.dart';

class PrayerItem {
  final String key;
  final TimeOfDay time;
  final bool sound, vibration;

  PrayerItem({
    required this.key,
    required this.time,
    this.sound = false,
    this.vibration = false,
  });
}
