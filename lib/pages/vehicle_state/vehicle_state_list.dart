import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dispatcher/data/fleet_data.dart';
import 'package:dispatcher/design/widgets/selectable_item.dart';

import '../../design/utils.dart';
import '../../design/widgets/accent_button.dart';

class VehicleStateList extends StatefulWidget {
  final String initialStateId;
  final ValueChanged<VehicleStateModel> onSave;

  const VehicleStateList({
    super.key,
    required this.initialStateId,
    required this.onSave,
  });

  @override
  State<VehicleStateList> createState() => _VehicleStateListState();
}

class _VehicleStateListState extends State<VehicleStateList> {
  late String _selectedStateId;

  @override
  void initState() {
    super.initState();
    _selectedStateId = widget.initialStateId;
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
    final List<VehicleStateModel> states = FleetStorage.vehicleStates;
    return ListView.separated(
      itemCount: states.length,
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
        final VehicleStateModel state = states[index];
        final bool isSelected = _selectedStateId == state.id;
        return SelectableItem(
          image: SvgPicture.asset(state.imageAsset),
          leftPadding: 16,
          title: state.title,
          isSelected: isSelected,
          onTap: () {
            setState(() {
              _selectedStateId = state.id;
            });
          },
        );
      },
    );
  }

  Widget _saveButton() {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: AccentButton(
        title: 'Save',
        onTap: () {
          widget.onSave(FleetStorage.stateById(_selectedStateId));
        },
      ),
    ));
  }
}
