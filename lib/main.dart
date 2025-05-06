import 'package:flutter/material.dart';
import 'package:sholat/flower/model.dart';
import 'package:sholat/flower/painter.dart';
import 'package:sholat/flower/view.dart';
import 'package:sholat/future/view.dart';
import 'package:sholat/info/view.dart';
import 'package:sholat/location/service.dart';
import 'package:sholat/prayer_time/service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Shalat")),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureView(
              future: LocationService.getCurrentLocation(),
              child:
                  (location) => FutureView(
                    future: PrayerTimeService.getBaseOnLocation(
                      latitude: location.latitude,
                      longitude: location.longitude,
                    ),
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
                          print("city $city");
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
                                    texts: [
                                      PainterText(
                                        title: "Dzuhur",
                                        subtitle: shalat.dhuhr,
                                        isMuted: false,
                                        onTap: () {},
                                      ),
                                      PainterText(
                                        title: "Asr",
                                        subtitle: shalat.asr,
                                        isMuted: false,
                                        onTap: () {},
                                      ),
                                      PainterText(
                                        title: "Magrib",
                                        subtitle: shalat.maghrib,
                                        isMuted: false,
                                        onTap: () {},
                                      ),
                                      PainterText(
                                        title: "Isya",
                                        subtitle: shalat.isha,
                                        isMuted: false,
                                        onTap: () {},
                                      ),
                                      PainterText(
                                        title: "Shubuh",
                                        subtitle: shalat.fajr,
                                        isMuted: true,
                                        onTap: () {},
                                      ),
                                      PainterText(
                                        title: "Terbit",
                                        subtitle: shalat.sunrise,
                                        isMuted: false,
                                        onTap: () {},
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
