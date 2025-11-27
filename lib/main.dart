import 'package:dispatcher/design/colors.dart';
import 'package:flutter/material.dart';
import 'package:dispatcher/pages/vehicle/vehicle_page.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dispatcher',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: surfaceColor,
      ),
      home: const VehiclePage(),
    );
  }
}
