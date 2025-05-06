import 'dart:convert';

import 'package:http/http.dart';
import 'package:sholat/prayer_time/model.dart';

class PrayerTimeService {
  static Future<PrayerTimeResponse> getBaseOnLocation({
    required double latitude,
    required double longitude,
  }) async {
    final url = Uri.parse(
      "https://api.aladhan.com/v1/timings/06-05-2025?latitude=$latitude&longitude=$longitude&method=20",
    );
    final response = await get(url);

    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return PrayerTimeResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load prayer timings');
    }
  }
}
