import 'package:flutter/material.dart';
import 'package:dispatcher/data/fleet_data.dart';
import 'package:dispatcher/design/colors.dart';
import 'package:dispatcher/pages/vehicle_state/vehicle_state_list.dart';

import '../../design/images.dart';
import '../../design/styles.dart';

class VehicleStatePage extends StatelessWidget {
  final String initialStateId;

  const VehicleStatePage({
    super.key,
    required this.initialStateId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update vehicle state', style: primaryTextStyle),
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
        child: VehicleStateList(
          initialStateId: initialStateId,
          onSave: (VehicleStateModel state) {
            Navigator.pop(context, state);
          },
        ),
      ),
    );
  }
}
