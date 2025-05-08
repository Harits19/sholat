import 'package:flutter/material.dart';

extension StringExtension on String {
  TimeOfDay toTimeOfDay() {
    final values = split(":");
    final hour = int.parse(values[0]);
    final minute = int.parse(values[1]);

    return TimeOfDay(hour: hour, minute: minute);
  }
}
