import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  const InfoView({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final String title, subtitle;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double fontSize = constraints.maxWidth / 8;

            return ListTile(
              onTap: onTap,
              title: Text(title, textAlign: TextAlign.center),
              subtitle: Text(
                subtitle,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitleTextStyle: TextStyle(fontSize: fontSize),
            );
          },
        ),
      ),
    );
  }
}
