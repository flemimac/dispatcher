import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:dispatcher/design/colors.dart';
import 'package:dispatcher/design/images.dart';
import 'package:dispatcher/design/styles.dart';

class SelectableItem extends StatelessWidget {
  final SvgPicture image;
  final double leftPadding;
  final Function() onTap;
  final String title;
  final bool isSelected;

  const SelectableItem({
    super.key,
    required this.image,
    required this.leftPadding,
    required this.onTap,
    required this.title,
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
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(left: leftPadding, right: 16),
            child: Row(
              children: <Widget>[
                image,
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    title,
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
