import 'package:flutter/services.dart';

class AlarmService {
  static const platform = MethodChannel('com.example.sholat/alarm');

  static Future<void> setAlarm({required int hour, required int minute}) async {
    await platform.invokeMethod('setAlarm', {'hour': hour, 'minute': minute});
  }
}
