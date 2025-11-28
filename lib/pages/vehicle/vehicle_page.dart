import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/fleet_data.dart';
import '../../design/styles.dart';
import '../../design/colors.dart';
import '../../design/widgets/accent_button.dart';

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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await _onAddVehicle(context);
            },
          ),
        ],
      ),
      body: Container(
        color: backgroundColor,
        child: const VehicleList(),
      ),
    );
  }

  Future<void> _onAddVehicle(BuildContext context) async {
    final _VehicleFormData? data = await _showVehicleDialog(context);
    if (data == null) {
      return;
    }
    FleetStorage.addVehicle(
      title: data.title,
      plate: data.plate,
      imageAsset: data.imageAsset,
    );
  }

  Future<_VehicleFormData?> _showVehicleDialog(BuildContext context) async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController plateController = TextEditingController();
    String selectedAsset = _vehicleImageOptions.first.imageAsset;
    final _VehicleFormData? result = await showDialog<_VehicleFormData>(
      context: context,
      builder: (BuildContext dialogContext) {
        String? error;
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Dialog(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Add vehicle', style: head1TextStyle),
                      const SizedBox(height: 12),
                      TextField(
                        controller: titleController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(labelText: 'Vehicle name'),
                      ),
                      TextField(
                        controller: plateController,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(labelText: 'Brand / plate'),
                      ),
                      const SizedBox(height: 16),
                      const Text('Vehicle icon', style: body1TextStyle),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _vehicleImageOptions
                            .map(
                              (_VehicleImageOption option) => _VehicleImageTile(
                                option: option,
                                isSelected: selectedAsset == option.imageAsset,
                                onTap: () {
                                  setState(() {
                                    selectedAsset = option.imageAsset;
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                      if (error != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            error!,
                            style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                          ),
                        ),
                      const SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.of(dialogContext).pop();
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: primaryColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  'Cancel',
                                  style: accentButtonTextStyle.copyWith(
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AccentButton(
                              title: 'Add',
                              onTap: () {
                                final String title = titleController.text.trim();
                                final String plate = plateController.text.trim();
                                if (title.isEmpty || plate.isEmpty) {
                                  setState(() {
                                    error = 'Please fill both fields';
                                  });
                                  return;
                                }
                                Navigator.of(dialogContext).pop(
                                  _VehicleFormData(
                                    title: title,
                                    plate: plate,
                                    imageAsset: selectedAsset,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
    return result;
  }
}

class _VehicleFormData {
  final String title;
  final String plate;
  final String imageAsset;

  const _VehicleFormData({
    required this.title,
    required this.plate,
    required this.imageAsset,
  });
}

class _VehicleImageOption {
  final String label;
  final String imageAsset;

  const _VehicleImageOption({
    required this.label,
    required this.imageAsset,
  });
}

const List<_VehicleImageOption> _vehicleImageOptions = <_VehicleImageOption>[
  _VehicleImageOption(label: 'Car', imageAsset: 'assets/images/vehicle_car.svg'),
  _VehicleImageOption(label: 'Truck', imageAsset: 'assets/images/vehicle_truck.svg'),
  _VehicleImageOption(label: 'Bus', imageAsset: 'assets/images/vehicle_bus.svg'),
  _VehicleImageOption(label: 'Motorcycle', imageAsset: 'assets/images/vehicle_motorcycle.svg'),
  _VehicleImageOption(label: 'Tuktuk', imageAsset: 'assets/images/vehicle_tuktuk.svg'),
];

class _VehicleImageTile extends StatelessWidget {
  final _VehicleImageOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const _VehicleImageTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.1) : surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? primaryColor : Colors.transparent, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              option.imageAsset,
              width: 40,
              height: 40,
            ),
            const SizedBox(height: 4),
            Text(
              option.label,
              style: body2TextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
