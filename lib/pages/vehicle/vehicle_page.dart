import 'package:flutter/material.dart';

import '../../design/styles.dart';
import '../../design/colors.dart';

import 'vehicle_list.dart';

class VehiclePage extends StatelessWidget {
  const VehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispatcher', style: primaryTextStyle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: surfaceColor,
      ),
      body: Container(
        color: backgroundColor,
        child: const VehicleList(),
      ),
    );
  }
}
