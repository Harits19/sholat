import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sholat/flower/model.dart';
import 'package:sholat/flower/painter.dart';
import 'package:sholat/location/service.dart';

class FlowerView extends StatefulWidget {
  const FlowerView({super.key, required this.texts, required this.position});

  final List<PainterText> texts;
  final Position position;

  @override
  State<FlowerView> createState() => _FlowerViewState();
}

class _FlowerViewState extends State<FlowerView> {
  final GlobalKey _paintKey = GlobalKey();
  late FlowerPainter _painter;

  double? _qiblaDirection;
  double? _heading;

  Future<void> _initLocationAndCompass() async {
    final position = widget.position;
    final qibla = LocationService.getQiblaLocation(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    FlutterCompass.events!.listen((event) {
      setState(() {
        _heading = event.heading;
        _qiblaDirection = qibla;
        final angle = (_qiblaDirection! - _heading!) % 360;

        _painter = FlowerPainter(texts: widget.texts, qiblaAngle: angle);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initLocationAndCompass();
    _painter = FlowerPainter(texts: widget.texts, qiblaAngle: 0);
  }

  void _handleTapDown(TapDownDetails details) {
    final RenderBox box =
        _paintKey.currentContext!.findRenderObject() as RenderBox;
    final Offset localPosition = box.globalToLocal(details.globalPosition);

    for (int i = 0; i < _painter.petalPaths.length; i++) {
      if (_painter.petalPaths[i].contains(localPosition)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tapped on petal: ${_painter.texts[i].title}'),
          ),
        );
        widget.texts[i].onTap();
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_heading == null || _qiblaDirection == null) {
      return Center(child: CircularProgressIndicator());
    }


    return GestureDetector(
      onTapDown: _handleTapDown,
      child: CustomPaint(
        size: Size(300, 300),
        painter: _painter,
        key: _paintKey,
      ),
    );
  }
}
