import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:dispatcher/data/fleet_data.dart';
import 'package:dispatcher/design/colors.dart';
import 'package:dispatcher/design/styles.dart';

class VehicleItem extends StatelessWidget {
  final VehicleModel vehicle;
  final DriverModel? driver;
  final VehicleStateModel state;
  final Function() onTap;
  final Function() onStateTap;

  const VehicleItem({
    super.key,
    required this.vehicle,
    required this.driver,
    required this.state,
    required this.onTap,
    required this.onStateTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Card(
        color: surfaceColor,
        margin: EdgeInsets.zero,
        elevation: 0.06,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: Row(
              children: <Widget>[
                _vehicleImage(),
                _title(),
                _state(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${vehicle.title} ${vehicle.plate}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: body2TextStyle,
            ),
            if (driver == null)
              const Text(
                'No driver',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: hint1TextStyle,
              )
            else
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Driver: ',
                      style: hint1TextStyle,
                    ),
                    TextSpan(
                      text: driver!.name,
                      style: body2TextStyle,
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _state() {
    return InkWell(
      onTap: onStateTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            state.imageAsset,
            width: 32,
            height: 32,
          ),
          Text(
            state.title.toLowerCase(),
            style: hint2TextStyle,
          )
        ],
      ),
    );
  }

  Widget _vehicleImage() {
    return SvgPicture.asset(
      vehicle.imageAsset,
      width: 48,
      height: 48,
    );
  }
}
