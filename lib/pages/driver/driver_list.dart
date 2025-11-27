import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dispatcher/data/fleet_data.dart';
import 'package:dispatcher/design/widgets/selectable_item.dart';

import '../../design/utils.dart';
import '../../design/widgets/accent_button.dart';

class DriverList extends StatefulWidget {
  final String? initialDriverId;
  final ValueChanged<DriverModel?> onSave;

  const DriverList({
    super.key,
    required this.initialDriverId,
    required this.onSave,
  });

  @override
  State<DriverList> createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  String? _selectedDriverId;

  @override
  void initState() {
    super.initState();
    _selectedDriverId = widget.initialDriverId;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _list(),
        Align(alignment: Alignment.bottomCenter, child: _saveButton()),
      ],
    );
  }

  Widget _list() {
    final List<DriverModel> drivers = FleetStorage.drivers;
    return ListView.separated(
      itemCount: drivers.length,
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
        final DriverModel driver = drivers[index];
        final bool isSelected = _selectedDriverId == driver.id;
        return SelectableItem(
          image: SvgPicture.asset(driver.imageAsset),
          leftPadding: 8,
          title: driver.name,
          isSelected: isSelected,
          onTap: () {
            setState(() {
              _selectedDriverId = driver.id;
            });
          },
        );
      },
    );
  }

  DriverModel? _currentSelection() {
    return FleetStorage.driverById(_selectedDriverId);
  }

  Widget _saveButton() {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: AccentButton(
        title: 'Save',
        onTap: () {
          widget.onSave(_currentSelection());
        },
      ),
    ));
  }
}
