import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sholat/shared_pref/model.dart';

class SharedPrefService {
  final SharedPrefKey key;
  final SharedPreferences pref;

  SharedPrefService({required this.key, required this.pref});

  static Future<SharedPrefService> create({required SharedPrefKey key}) async {
    final pref = await SharedPreferences.getInstance();

    return SharedPrefService(key: key, pref: pref);
  }

  String get keyValue => key.name;

  Future<void> set(Object object) async {
    final value = jsonEncode(object);
    await pref.setString(keyValue, value);
  }

  Future<dynamic> get() async {
    final result = pref.getString(keyValue);

    if (result == null) return;

    return jsonDecode(result);
  }
}
