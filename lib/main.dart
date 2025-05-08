import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sholat/alarm/service.dart';
import 'package:sholat/flower/model.dart';
import 'package:sholat/flower/view.dart';
import 'package:sholat/future/view.dart';
import 'package:sholat/info/view.dart';
import 'package:sholat/location/service.dart';
import 'package:sholat/prayer_time/model.dart';
import 'package:sholat/prayer_time/service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int key = 0;

  Future<PrayerTimeResponse> getPrayerTime(Position location) async {
    final result = await PrayerTimeService.getBaseOnLocation(
      latitude: location.latitude,
      longitude: location.longitude,
    );
    await setPrayerTimings(result.data.timings);

    return result;
  }

  Future<void> setPrayerTimings(Timings timings) async {
    final prayerTimes = [
      timings.fajr,
      timings.sunrise,
      timings.dhuhr,
      timings.asr,
      timings.maghrib,
      timings.isha,
    ];

    for (final prayer in prayerTimes) {
      await AlarmService.setAlarm(hour: prayer.hour, minute: prayer.minute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text("Shalat")),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureView(
              key: Key(key.toString()),
              future: LocationService.getCurrentLocation(),
              child:
                  (location) => FutureView(
                    future: getPrayerTime(location),
                    child: (data) {
                      final date = data.data.date;
                      final masehi = date.gregorian;
                      final hijri = date.hijri;
                      final shalat = data.data.timings;

                      return FutureView(
                        future: LocationService.getCityName(
                          latitude: location.latitude,
                          longitude: location.longitude,
                        ),
                        child: (city) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  InfoView(
                                    title: masehi.day,
                                    subtitle: masehi.month.en,
                                  ),
                                  InfoView(
                                    title: masehi.weekday.en,
                                    subtitle: city,
                                    onTap: () {
                                      key = key + 1;
                                      setState(() {});
                                    },
                                  ),
                                  InfoView(
                                    title: hijri.day,
                                    subtitle: hijri.month.en,
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Center(
                                  child: FlowerView(
                                    position: location,
                                    texts: [
                                      PrayerItem(
                                        key: "Dzuhur",
                                        time: shalat.dhuhr,
                                      ),
                                      PrayerItem(key: "Asr", time: shalat.asr),
                                      PrayerItem(
                                        key: "Magrib",
                                        time: shalat.maghrib,
                                      ),
                                      PrayerItem(
                                        key: "Isya",
                                        time: shalat.isha,
                                      ),
                                      PrayerItem(
                                        key: "Shubuh",
                                        time: shalat.fajr,
                                      ),
                                      PrayerItem(
                                        key: "Terbit",
                                        time: shalat.sunrise,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
