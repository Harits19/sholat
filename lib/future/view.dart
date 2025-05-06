import 'package:flutter/material.dart';

class FutureView<T> extends StatelessWidget {
  final Widget Function(T) child;
  final Future<T> future;

  const FutureView({super.key, required this.child, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        return Center(
          child:
              (() {
                final data = snapshot.data;

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (data == null) {
                  return Text('No data found.');
                }

                return child(data);
              })(),
        );
      },
    );
  }
}
