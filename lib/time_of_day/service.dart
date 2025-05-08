import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  /// e.g 13:30
  String format1() {
    addZero(int value) {
      return value.toString().padLeft(2, '0');
    }

    return "${addZero(hour)}:${addZero(minute)}";
  }
}
