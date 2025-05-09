import 'package:flutter/services.dart';

class AlarmService {
  static const platform = MethodChannel('com.example.sholat/alarm');

  static Future<void> setAlarm({
    required int hour,
    required int minute,
    required int id,
  }) async {
    print("start set alarm $hour $minute $id");
    await platform.invokeMethod('setAlarm', {
      'hour': hour,
      'minute': minute,
      'id': id,
    });
  }
}
