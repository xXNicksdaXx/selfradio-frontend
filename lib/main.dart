import 'package:flutter/material.dart';
import 'package:selfradio/src/api/locator.dart';
import 'package:selfradio/src/views/navigation_bar.dart' as nb;

void main() {
  setup();
  runApp(const Selfradio());
}

class Selfradio extends StatelessWidget {
  const Selfradio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Selfradio',
      home: nb.NavigationBar(),
    );
  }
}