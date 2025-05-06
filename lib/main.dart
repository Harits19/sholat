import 'package:flutter/material.dart';
import 'package:sholat/flower/painter.dart';
import 'package:sholat/flower/view.dart';
import 'package:sholat/future/view.dart';
import 'package:sholat/info/view.dart';
import 'package:sholat/location/service.dart';

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
              future: Future.value(10),
              child:
                  (data) => Column(
                    children: [
                      Row(
                        children: [
                          InfoView(title: "6", subtitle: "Mei"),
                          InfoView(title: "Selasa", subtitle: "Jakarta"),
                          InfoView(title: "8", subtitle: "Dzulqadah"),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: CustomPaint(
                            size: Size(300, 300),
                            painter: FlowerPainter(),
                          ),
                        ),
                      ),
                    ],
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
