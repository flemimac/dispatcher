import 'package:flutter/material.dart';
import 'package:dispatcher/data/fleet_data.dart';
import 'package:dispatcher/design/images.dart';
import 'package:dispatcher/pages/driver/driver_list.dart';

import '../../design/styles.dart';
import '../../design/colors.dart';

class DriverPage extends StatelessWidget {
  final String? initialDriverId;

  const DriverPage({
    super.key,
    required this.initialDriverId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select driver', style: primaryTextStyle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: surfaceColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: arrowBackImage),
      ),
      body: Container(
        color: backgroundColor,
        child: DriverList(
          initialDriverId: initialDriverId,
          onSave: (DriverModel? driver) {
            Navigator.pop(context, driver);
          },
        ),
      ),
    );
  }
}
