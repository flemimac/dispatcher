import 'package:flutter/material.dart';
import 'package:dispatcher/design/colors.dart';
import 'package:dispatcher/design/styles.dart';

class AccentButton extends StatelessWidget {
  final String title;
  final Function() onTap;

  const AccentButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 40),
            maximumSize: const Size.fromHeight(40),
            backgroundColor: primaryColor,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.only(left: 16, right: 16)),
        child: Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          title,
          style: accentButtonTextStyle,
        ));
  }
}
