import 'package:flutter/material.dart';
import 'package:sholat/flower/model.dart';
import 'package:sholat/flower/painter.dart';

class FlowerView extends StatefulWidget {
  const FlowerView({super.key, required this.texts});

  final List<PainterText> texts;

  @override
  State<FlowerView> createState() => _FlowerViewState();
}

class _FlowerViewState extends State<FlowerView> {
  final GlobalKey _paintKey = GlobalKey();
  late FlowerPainter _painter;

  @override
  void initState() {
    super.initState();
    _painter = FlowerPainter(texts: widget.texts);
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
