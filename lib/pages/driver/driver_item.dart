import 'package:flutter/material.dart';

import 'package:dispatcher/design/colors.dart';
import 'package:dispatcher/design/images.dart';
import 'package:dispatcher/design/styles.dart';

class DriverItem extends StatelessWidget {
  final Function() onTap;
  final String driverName;
  final bool isSelected;

  const DriverItem({
    super.key,
    required this.onTap,
    required this.driverName,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return _list();
  }

  Widget _list() {
    return SizedBox(
      height: 64,
      child: Card(
        color: surfaceColor,
        margin: EdgeInsets.zero,
        elevation: 0.06,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: Row(
              children: <Widget>[
                accountCircleImage,
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    driverName,
                    style: body2TextStyle,
                  ),
                ),
                const SizedBox(width: 16),
                if (isSelected) checkImage
              ],
            ),
          ),
        ),
      ),
    );
  }
}
