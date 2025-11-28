import 'package:flutter/material.dart';
import 'package:dispatcher/data/fleet_data.dart';
import 'package:dispatcher/design/images.dart';
import 'package:dispatcher/pages/driver/driver_list.dart';

import '../../design/styles.dart';
import '../../design/colors.dart';
import '../../design/widgets/accent_button.dart';

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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await _onAddDriver(context);
            },
          ),
        ],
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

  Future<void> _onAddDriver(BuildContext context) async {
    final String? name = await _showAddDriverDialog(context);
    if (name == null) {
      return;
    }
    FleetStorage.addDriver(name: name);
  }

  Future<String?> _showAddDriverDialog(BuildContext context) async {
    final TextEditingController controller = TextEditingController();
    final String? result = await showDialog<String>(
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
                      const Text('Add driver', style: head1TextStyle),
                      const SizedBox(height: 12),
                      TextField(
                        controller: controller,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(labelText: 'Driver name'),
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
                                final String name = controller.text.trim();
                                if (name.isEmpty) {
                                  setState(() {
                                    error = 'Please enter driver name';
                                  });
                                  return;
                                }
                                Navigator.of(dialogContext).pop(name);
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
