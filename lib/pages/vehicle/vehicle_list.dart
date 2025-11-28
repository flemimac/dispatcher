import 'package:flutter/material.dart';
import 'package:dispatcher/data/fleet_data.dart';
import 'package:dispatcher/pages/driver/driver_page.dart';
import 'package:dispatcher/pages/vehicle/vehicle_item.dart';
import 'package:dispatcher/pages/vehicle_state/vehicle_state_page.dart';

import '../../design/dialog/dialog.dart';
import '../../design/utils.dart';
import '../../design/widgets/accent_button.dart';
import '../../design/styles.dart';
import '../../design/colors.dart';

class VehicleList extends StatelessWidget {
  const VehicleList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<VehicleModel>>(
      valueListenable: FleetStorage.vehiclesNotifier,
      builder: (BuildContext context, List<VehicleModel> vehicles, _) {
        return Stack(
          children: <Widget>[
            _list(context, vehicles),
            Align(alignment: Alignment.bottomCenter, child: _updateButton(context)),
          ],
        );
      },
    );
  }

  Widget _list(BuildContext context, List<VehicleModel> vehicles) {
    return ListView.separated(
      itemCount: vehicles.length,
      padding: EdgeInsets.only(
        left: 16,
        top: 16,
        right: 16,
        bottom: getListBottomPadding(context),
      ),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 8);
      },
      itemBuilder: (BuildContext context, int index) {
        final VehicleModel vehicle = vehicles[index];
        return VehicleItem(
          vehicle: vehicle,
          driver: FleetStorage.driverById(vehicle.driverId),
          state: FleetStorage.stateById(vehicle.stateId),
          onTap: () async {
            await _showDriverPage(context, vehicle);
          },
          onStateTap: () async {
            await _showVehicleStatePage(context, vehicle);
          },
          onLongPress: () async {
            await _showDeleteVehicleDialog(context, vehicle);
          },
        );
      },
    );
  }

  Widget _updateButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        child: AccentButton(
          title: 'Update',
          onTap: () async {
            await _refreshVehicles(context);
          },
        ),
      ),
    );
  }

  Future<void> _refreshVehicles(BuildContext context) async {
    await FleetStorage.refreshVehicles();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ErrorDialog(description: "Data updated successfully!");
      });
  }

  Future<void> _showDriverPage(BuildContext context, VehicleModel vehicle) async {
    final DriverModel? selectedDriver =
        await Navigator.push<DriverModel?>(context, MaterialPageRoute(builder: (context) {
      return DriverPage(initialDriverId: vehicle.driverId);
    }));
    if (selectedDriver == null) {
      return;
    }
    FleetStorage.updateVehicleDriver(
      vehicleId: vehicle.id,
      driverId: selectedDriver.id,
    );
  }

  Future<void> _showVehicleStatePage(
      BuildContext context, VehicleModel vehicle) async {
    final VehicleStateModel? selectedState = await Navigator.push<VehicleStateModel?>(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return VehicleStatePage(initialStateId: vehicle.stateId);
        },
      ),
    );
    if (selectedState == null) {
      return;
    }
    FleetStorage.updateVehicleState(
      vehicleId: vehicle.id,
      stateId: selectedState.id,
    );
  }

  Future<void> _showDeleteVehicleDialog(
    BuildContext context,
    VehicleModel vehicle,
  ) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Delete vehicle', style: head1TextStyle),
                const SizedBox(height: 8),
                Text(
                  'Are you sure you want to delete ${vehicle.title}?',
                  style: body1TextStyle,
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop(false);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: accentButtonTextStyle.copyWith(color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AccentButton(
                        title: 'Delete',
                        onTap: () {
                          Navigator.of(dialogContext).pop(true);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (confirmed == true) {
      FleetStorage.removeVehicle(vehicleId: vehicle.id);
    }
  }
}
