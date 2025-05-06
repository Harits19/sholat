import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  const InfoView({super.key, required this.title, required this.subtitle});

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(child: ListTile(title: Text(title), subtitle: Text(subtitle))),
    );
  }
}
